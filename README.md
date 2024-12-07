An AI-powered healthcare assistant that helps medical professionals retrieve and analyze patient information through natural language queries. The system uses LLMs to provide intelligent responses to medical queries.


Installation

1.Clone the repository
git clone [your-repository-url]
cd healthcare-assistant

2. Create and activate virtual environment
python -m venv .venv
# On Windows
.venv\Scripts\activate
# On Unix or MacOS
source .venv/bin/activate

3. Install dependencies
pip install -r requirements.txt

4. Set up the database
Start XAMPP and ensure MySQL is running
Create a database named 'healthcare_db'
Import the schema from database/schema.sql

6. Configure environment variables Create a .env file in the root directory
OPENAI_API_KEY=your_openai_api_key_here

Running the Application

1. Start the backend server
uvicorn api.main:app --reload

2. Open the frontend
Navigate to the frontend directory
Open index.html in a web browser

Now, enjoy healthcare-assistant!
