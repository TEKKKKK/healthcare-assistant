from dotenv import load_dotenv
import os

load_dotenv()

DATABASE_CONFIG = {
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'database': 'healthcare_db'
}

OPENAI_API_KEY = os.getenv('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')