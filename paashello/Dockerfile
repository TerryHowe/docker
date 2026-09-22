FROM python:3.13-slim

RUN apt-get install

WORKDIR /app
COPY app.py /app/
COPY requirements.txt /app/

RUN pip install -r requirements.txt

EXPOSE 5000

ENTRYPOINT ["python", "app.py"]
