# Use a lightweight Python image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install git (if needed) and remove cache to save space
RUN apt-get update && apt-get install -y git \
    && rm -rf /var/lib/apt/lists/*

# Copy project files
COPY app/ /app

# Install only the minimal required Python packages
RUN pip install --upgrade pip \
    && pip install Flask==2.3.3

# Expose port 5000 for Flask
EXPOSE 5000

# Ensure Python output is unbuffered
ENV PYTHONUNBUFFERED=1

# Entry point: run your lightweight chatbot app
CMD ["python", "app.py"]
