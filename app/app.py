from flask import Flask, jsonify
import os
import time

app = Flask(__name__)

@app.route("/")
def home():
    return jsonify({
        "message": "DevOps Assignment Application",
        "environment": os.getenv("ENVIRONMENT", "local"),
        "status": "healthy"
    })


@app.route("/health")
def health():
    return jsonify({
        "status": "healthy"
    }), 200


@app.route("/api")
def api():
    return jsonify({
        "message": "Application API is working"
    })


if __name__ == "__main__":
    app.run(
        host="0.0.0.0",
        port=int(os.getenv("PORT", "5000"))
    )