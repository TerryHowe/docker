FROM python:2.7
 
COPY requirements.txt /
RUN pip install -r /requirements.txt
RUN rm -f /requirements.txt

RUN mkdir -p /kafka
WORKDIR /kafka
COPY sink.py /kafka/
 
ENTRYPOINT ["python", "/kafka/sink.py"]
