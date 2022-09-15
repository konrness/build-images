FROM python:3

LABEL maintainer="konrness@gmail.com"
LABEL source="https://github.com/konrness/build-images"

WORKDIR /bin

RUN pip install --no-cache-dir trcli testrail-api

ADD ./entrypoint.sh /bin
RUN chmod +x /bin/entrypoint.sh
ADD ./testrail.py /bin/testrail.py

ENTRYPOINT ["entrypoint.sh"]