# Use a lightweight Python image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install git (if needed) and remove cache to save space
RUN apt-get update && apt-get install -y git \
    && rm -rf /var/lib/apt/lists/*

# Copy project files
COPY . /app

# Install only minimal required packages
RUN pip install --upgrade pip \
    && pip install Flask==2.3.3 \
    && pip install chatterbot==1.0.5 chatterbot_corpus==1.2.0

# Expose port if using Flask example
EXPOSE 5000

# Ensure Python output is unbuffered
ENV PYTHONUNBUFFERED=1

# Entry point: choose example script
# For terminal chatbot:
# CMD ["python", "examples/terminal_example.py"]

# For Flask chatbot (web server):
CMD ["python", "examples/flask_example.py"]
