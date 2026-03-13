from fastapi import FastAPI

app = FastAPI(title="Ultimate Planner API")


@app.get("/health")
def health() -> dict[str, str]:
    return {"status": "ok"}
