FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
	PYTHONUNBUFFERED=1 \
	PIP_NO_CACHE_DIR=1

WORKDIR /app

# libpq-dev is required by some PostgreSQL Python drivers during install.
RUN apt-get update \
	&& apt-get install -y --no-install-recommends build-essential libpq-dev \
	&& rm -rf /var/lib/apt/lists/*

# Copy dependency list first to maximize Docker layer cache hit rate.
COPY requirements.txt ./

RUN pip install --upgrade pip \
	&& pip install -r requirements.txt

COPY . .

EXPOSE 8000

# Default command for a FastAPI app located at app/main.py as `app = FastAPI()`.
# Change module path if your entrypoint is different.
CMD ["python", "-m", "uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
