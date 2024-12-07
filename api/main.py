# File: api/main.py
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import Optional
import logging
from llm.query_processor import QueryProcessor

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = FastAPI()

# CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Define request model
class QueryRequest(BaseModel):
    text: str
    patient_id: Optional[int] = None

# Initialize QueryProcessor
try:
    query_processor = QueryProcessor()
except Exception as e:
    logger.error(f"Failed to initialize QueryProcessor: {str(e)}")
    query_processor = None

@app.get("/")
async def root():
    return {"message": "Healthcare Assistant API is running"}

@app.get("/health")
async def health_check():
    return {"status": "healthy", "llm_status": "initialized" if query_processor else "not initialized"}

@app.post("/query")
async def process_query(query: QueryRequest):
    if not query_processor:
        raise HTTPException(status_code=500, detail="LLM not initialized")
    
    try:
        response = query_processor.process_query(query.text)
        return {"response": response}
    except Exception as e:
        logger.error(f"Error processing query: {str(e)}")
        raise HTTPException(status_code=500, detail=str(e))