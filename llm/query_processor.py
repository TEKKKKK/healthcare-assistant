from langchain_openai import OpenAI
from langchain.chains import LLMChain
from langchain.prompts import PromptTemplate
from typing import Dict, Any
import json
import mysql.connector
from datetime import datetime

class QueryProcessor:
    def __init__(self):
        # Initialize OpenAI LLM
        self.llm = OpenAI(
            temperature=0.7,
            model_name="gpt-3.5-turbo-instruct"
        )

        # Database connection configuration
        self.db_config = {
            'host': 'localhost',
            'user': 'root',
            'password': '',
            'database': 'healthcare_db'
        }

        # Define prompt template for the LLM
        self.prompt_template = PromptTemplate(
            input_variables=["query", "patient_data"],
            template="""
            You are a healthcare assistant helping medical professionals access patient information.
            Using the patient data provided below, answer the following query in a clear, professional manner.
            Only use information that is present in the patient data. If information is not available, say so.
            
            Patient Data:
            {patient_data}
            
            Query: {query}
            
            Please provide a concise, relevant response focusing on the requested information.
            """
        )
        
        # Create LangChain
        self.chain = LLMChain(llm=self.llm, prompt=self.prompt_template)

    def get_db_connection(self):
        """Create and return a database connection"""
        try:
            return mysql.connector.connect(**self.db_config)
        except mysql.connector.Error as e:
            raise Exception(f"Database connection failed: {str(e)}")

    def load_patient_data(self):
        """Load all patient data from database"""
        conn = self.get_db_connection()
        cursor = conn.cursor(dictionary=True)
        
        try:
            # Get all patients
            cursor.execute("""
                SELECT 
                    p.id,
                    p.first_name,
                    p.last_name,
                    p.date_of_birth,
                    p.medical_history,
                    p.current_medications,
                    p.allergies,
                    p.last_visit,
                    GROUP_CONCAT(DISTINCT mr.diagnosis) as diagnoses,
                    GROUP_CONCAT(DISTINCT mr.treatment) as treatments,
                    GROUP_CONCAT(DISTINCT mr.notes ORDER BY mr.record_date DESC) as recent_notes
                FROM patients p
                LEFT JOIN medical_records mr ON p.id = mr.patient_id
                GROUP BY p.id
            """)
            
            patients = {}
            for row in cursor.fetchall():
                full_name = f"{row['first_name'].lower()} {row['last_name'].lower()}"
                
                # Format the patient data
                patients[full_name] = {
                    "allergies": row['allergies'].split(',') if row['allergies'] else "None",
                    "conditions": row['medical_history'].split(',') if row['medical_history'] else [],
                    "medications": row['current_medications'].split(',') if row['current_medications'] else [],
                    "last_visit": row['last_visit'].strftime('%Y-%m-%d') if row['last_visit'] else "No recent visits",
                    "notes": row['recent_notes'].split(',')[0] if row['recent_notes'] else "No recent notes",
                    "diagnoses": row['diagnoses'].split(',') if row['diagnoses'] else [],
                    "treatments": row['treatments'].split(',') if row['treatments'] else []
                }
            
            return patients

        except mysql.connector.Error as e:
            raise Exception(f"Database query failed: {str(e)}")
        finally:
            cursor.close()
            conn.close()

    def get_patient_from_query(self, query: str) -> str:
        """Extract patient name from query."""
        try:
            # Load current patient data
            patients = self.load_patient_data()
            
            query_lower = query.lower()
            for name in patients.keys():
                if name in query_lower:
                    return name
            return None

        except Exception as e:
            raise Exception(f"Error extracting patient name: {str(e)}")

    def process_query(self, query: str, context: str = "") -> str:
        try:
            # Load current patient data
            patients = self.load_patient_data()
            
            # Extract patient name from query
            patient_name = self.get_patient_from_query(query)
            
            if not patient_name:
                return "Please specify a patient name in your query. Available patients: " + ", ".join(name.title() for name in patients.keys())

            # Get relevant patient data
            patient_info = patients[patient_name]
            
            # Format patient data for the prompt
            formatted_patient_data = json.dumps(patient_info, indent=2)
            
            # Process query using LLM
            response = self.chain.run({
                "query": query,
                "patient_data": f"Patient Name: {patient_name.title()}\n{formatted_patient_data}"
            })
            
            return response.strip()

        except Exception as e:
            return f"Error processing query: {str(e)}"
