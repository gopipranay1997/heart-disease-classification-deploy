# FROM python:3.8
FROM jupyter/scipy-notebook

ENV http_proxy http://172.30.10.43:3128
ENV https_proxy http://172.30.10.43:3128

USER root

RUN dpkg --configure -a
RUN apt-get update && apt-get install -y jq

# Set the working directory
WORKDIR /app

# Copy the dependencies file to the working directory
COPY requirements.txt .

# Install the dependencies
RUN pip install -r requirements.txt

# Copy the source code to the working directory
COPY . .

# Set the Flask app environment variable
ENV FLASK_APP app.py

# Expose the Flask app port
EXPOSE 5000

# Run the Flask app
# CMD ["flask", "run", "--host=0.0.0.0"]
CMD ["python","preprocessing.py","train1.py","test.py","app.py"]
