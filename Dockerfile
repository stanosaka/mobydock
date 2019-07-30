FROM python:2.7.16-slim-buster
MAINTAINER Stan Zhou <devops@cwzhou.win>

RUN apt-get update && apt-get install -q -y build-essential libpq-dev postgresql-client --fix-missing --no-install-recommends

ENV INSTALL_PATH /mobydock
RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY . .

VOLUME ["static"]

CMD gunicorn -b 0.0.0.0:8000 "mobydock.app:create_app()"