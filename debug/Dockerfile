FROM alpine

LABEL maintainer="konrness@gmail.com"
LABEL source="https://github.com/konrness/build-images"

WORKDIR /usr/src/app

ADD ./entrypoint.sh /bin
RUN chmod +x /bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]