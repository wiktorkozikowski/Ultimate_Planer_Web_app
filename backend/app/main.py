from fastapi import FastAPI
from app.routes.status_routes import router as status_router

app = FastAPI(title="Ultimate Planner API")


@app.get("/health")
def health() -> dict[str, str]:
    return {"status": "ok"}


app.include_router(status_router)