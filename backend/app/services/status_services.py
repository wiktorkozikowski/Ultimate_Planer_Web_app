import os
import subprocess
import requests


def check_backend_status() -> dict:
    try:
        response = requests.get("http://localhost:8000/health", timeout=3)

        if response.status_code == 200:
            return {"service": "backend", "status": "ok"}

        return {"service": "backend", "status": "error"}
    except Exception as error:
        return {"service": "backend", "status": "error", "details": str(error)}


def check_db_status() -> dict:
    try:
        user = os.getenv("POSTGRES_USER")
        db = os.getenv("POSTGRES_DB")

        result = subprocess.run(
            ["pg_isready", "-U", user, "-d", db],
            capture_output=True,
            text=True,
            timeout=5,
        )

        if result.returncode == 0:
            return {"service": "db", "status": "ok"}

        return {"service": "db", "status": "error", "details": result.stderr}
    except Exception as error:
        return {"service": "db", "status": "error", "details": str(error)}


def check_frontend_status() -> dict:
    try:
        response = requests.get("http://frontend:3000", timeout=3)

        if response.status_code == 200:
            return {"service": "frontend", "status": "ok"}

        return {"service": "frontend", "status": "error"}
    except Exception as error:
        return {"service": "frontend", "status": "error", "details": str(error)}