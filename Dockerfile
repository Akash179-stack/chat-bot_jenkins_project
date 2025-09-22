# Use an official Python base image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install dependencies needed for build & chatterbot
# slim image may need build tools for some dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy project files
# If you clone the repo before building, COPY local repo
# Or you can clone inside Docker
# We'll assume you copy your local copy
COPY . /app

# Alternatively, clone from GitHub directly:
# RUN git clone https://github.com/gunthercox/ChatterBot.git /app

# Install python dependencies
# ChatterBot uses pyproject.toml, setup.cfg etc.
RUN pip install --upgrade pip \
    && pip install poetry \
    && poetry config virtualenvs.create false \
    && poetry install --no-dev

# If not using poetry, you might do:
# RUN pip install -r requirements.txt

# Expose a port if your bot offers a REST API (modify if needed)
EXPOSE 5000

# Define environment variables (modify as per your script)
ENV PYTHONUNBUFFERED=1

# Entry point (modify as needed)
CMD ["python", "examples/terminal_example.py"]
