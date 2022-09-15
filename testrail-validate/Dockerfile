FROM python:3

LABEL maintainer="konrness@gmail.com"
LABEL source="https://github.com/konrness/build-images"

WORKDIR /usr/src/app

RUN pip install --no-cache-dir trcli testrail-api

ADD ./entrypoint.sh /bin
RUN chmod +x /bin/entrypoint.sh
ADD ./testrail.py /usr/src/app/testrail.py

ENTRYPOINT ["entrypoint.sh"]