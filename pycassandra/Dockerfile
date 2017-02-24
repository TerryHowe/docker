FROM python:2.7

RUN apt-get install

WORKDIR /app
RUN mkdir /app/static/
COPY app.py /app/
COPY apples.png /app/static/
COPY bananas.png /app/static/
COPY cherrys.png /app/static/
COPY requirements.txt /app/

RUN pip install -r requirements.txt

EXPOSE 5000

ENTRYPOINT ["python", "app.py"]
