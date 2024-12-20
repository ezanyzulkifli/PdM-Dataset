# Use an official Python runtime as a parent image 
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Install system libraries required by pandas and numpy 
RUN apt-get update && apt-get install -y \
    libatlas-base-dev gfortran

# Copy the current directory contents into the container at /app 
COPY - /app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy model and scaler from the current directory 
COPY app/finalized_model.pkl /app

# Make port 8080 available to the world outside this container 
EXPOSE 8080

# Define environment variable
#ENV OPENAI_API_KEY sk-proj-eAjzhHlr9lib6LAsw9PgT3B1bkFJXZFno2wnPNtEAHT1EUFC

# Run app.py when the container launches
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "flask_app:app"]
