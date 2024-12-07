import mysql.connector
from config import DATABASE_CONFIG

class DatabaseManager:
    def __init__(self):
        self.connection = mysql.connector.connect(**DATABASE_CONFIG)
        self.cursor = self.connection.cursor(dictionary=True)

    def get_patient_info(self, patient_id):
        query = """
        SELECT p.*, GROUP_CONCAT(mr.diagnosis) as diagnoses
        FROM patients p
        LEFT JOIN medical_records mr ON p.id = mr.patient_id
        WHERE p.id = %s
        GROUP BY p.id
        """
        self.cursor.execute(query, (patient_id,))
        return self.cursor.fetchone()

    def search_patients(self, search_term):
        query = """
        SELECT * FROM patients 
        WHERE first_name LIKE %s 
        OR last_name LIKE %s
        """
        search_pattern = f"%{search_term}%"
        self.cursor.execute(query, (search_pattern, search_pattern))
        return self.cursor.fetchall()

    def add_medical_record(self, patient_id, diagnosis, treatment, notes):
        query = """
        INSERT INTO medical_records (patient_id, record_date, diagnosis, treatment, notes)
        VALUES (%s, CURDATE(), %s, %s, %s)
        """
        self.cursor.execute(query, (patient_id, diagnosis, treatment, notes))
        self.connection.commit()

    def close(self):
        self.cursor.close()
        self.connection.close()
