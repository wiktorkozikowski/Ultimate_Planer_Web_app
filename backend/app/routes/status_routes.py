from fastapi import APIRouter
from app.services.status_services import (
    check_backend_status,
    check_db_status,
    check_frontend_status,
)

router = APIRouter(prefix="/status", tags=["status"])


@router.get("")
def get_status() -> dict:
    return {
        "backend": check_backend_status(),
        "db": check_db_status(),
        "frontend": check_frontend_status(),
    }