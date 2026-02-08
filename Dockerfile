# Use a Python:3.9-slim image as the base
FROM python:3.9-slim

# Create working folder and install dependencies
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application contents
COPY service/ ./service/

# Switch to a non-root user for security
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# Expose the port the app runs on
EXPOSE 8080

# Use gunicorn as the entry point
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]