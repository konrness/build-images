FROM alpine:latest

LABEL maintainer="konrness@gmail.com"
LABEL source="https://github.com/konrness/build-images"

WORKDIR /bin

# Install curl and docker-cli
RUN apk update && apk add --no-cache \
    curl \
    docker-cli

ADD ./entrypoint.sh /bin
RUN chmod +x /bin/entrypoint.sh

ENTRYPOINT ["/bin/entrypoint.sh"]
