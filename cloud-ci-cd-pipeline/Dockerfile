# Use a multi-stage build for a smaller final image
FROM python:3.9-slim AS builder

# Set work directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    libc6-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --user -r requirements.txt

# Second stage
FROM python:3.9-slim

# Set work directory
WORKDIR /app

# Copy only the dependencies installation from the 1st stage image
COPY --from=builder /root/.local /root/.local

# Ensure scripts in .local are usable:
ENV PATH=/root/.local/bin:$PATH

# Copy application code
COPY src/app .

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    DYNAMODB_TABLE_NAME=your-table-name

# Expose the port the app runs on
EXPOSE 8000

# Run the application
CMD ["gunicorn", "-w", "4", "-k", "uvicorn.workers.UvicornWorker", "-b", "0.0.0.0:8000", "main:app"]