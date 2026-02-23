#!/usr/bin/env python3
"""
Simple REST API for DevOps Assignment
Runs on port 8080 with two endpoints:
- / : Returns a simple text response
- /health : Returns health check status
"""

from flask import Flask, jsonify
import logging
import sys

# Configure logging to stdout
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    stream=sys.stdout
)

logger = logging.getLogger(__name__)

app = Flask(__name__)

@app.route('/')
def home():
    """Root endpoint - returns a simple message"""
    logger.info("Received request on / endpoint")
    return "Welcome to DevOps Assignment REST API! Server is running successfully.\n"

@app.route('/health')
def health():
    """Health check endpoint"""
    logger.info("Received request on /health endpoint")
    return jsonify({
        "status": "ok",
        "message": "Application is healthy"
    }), 200

if __name__ == '__main__':
    logger.info("Starting REST API server on port 8080...")
    app.run(host='0.0.0.0', port=8080, debug=False)
