FROM python:3.7-slim-buster
RUN apt-get update && \
    apt-get upgrade -y
WORKDIR /app
ADD app.py /app
ADD requirements.txt /app
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
CMD ["app.py"]
ENTRYPOINT ["python3"]