FROM alpine

LABEL maintainer="konrness@gmail.com"
LABEL source="https://github.com/konrness/build-images"

WORKDIR /bin

ADD ./entrypoint.sh /bin
RUN chmod +x /bin/entrypoint.sh

RUN apk update
RUN apk add -f lshw

ENTRYPOINT ["/bin/entrypoint.sh"]
