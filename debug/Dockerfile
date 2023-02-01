FROM alpine

LABEL maintainer="konrness@gmail.com"
LABEL source="https://github.com/konrness/build-images"

WORKDIR /bin

ADD ./entrypoint.sh /bin
RUN chmod +x /bin/entrypoint.sh

ENTRYPOINT ["/bin/entrypoint.sh"]
