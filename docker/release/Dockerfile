FROM python:2.7-alpine

LABEL MAINTAINER="Thomas Nyambati <thomasnyambati@gmail.com>"
LABEL application="fluffy"

# Prevent dpkg errors
ENV TERM=xterm-256color

# Installing build dependencies
RUN apk update && \
    apk add build-base python-dev py-pip py-pip jpeg-dev zlib-dev && \
    apk add postgresql-dev libpq

RUN pip install --upgrade pip

WORKDIR /usr/src/fluffy

COPY src/requirements.txt /usr/src/fluffy/requirements.txt

RUN pip install -r requirements.txt

COPY src /usr/src/fluffy
