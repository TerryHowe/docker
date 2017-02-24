FROM python:2.7-onbuild
COPY requirements.txt /requirements.txt
COPY application.py /application.py
RUN pip install pip
RUN pip install -r requirements.txt
CMD [ "python", "/application.py" ]
