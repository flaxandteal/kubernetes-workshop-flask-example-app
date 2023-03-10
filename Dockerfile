FROM python:3.8-alpine

RUN addgroup -S user && adduser user -S -G user

WORKDIR /home/user/

COPY requirements.txt   .
COPY gunicorn_config.py .
COPY setup.py           .
COPY setup.cfg          .

RUN apk update && apk add postgresql-dev gcc python3-dev musl-dev
RUN pip install gunicorn
RUN pip install -r requirements.txt

USER user

EXPOSE 5000

ENTRYPOINT []

CMD gunicorn --config ./gunicorn_config.py magnumopus.index:app

COPY magnumopus         magnumopus
