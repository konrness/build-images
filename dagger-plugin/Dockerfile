FROM alpine:latest

LABEL maintainer="konrness@gmail.com"
LABEL source="https://github.com/konrness/build-images"

WORKDIR /bin

# Install curl and docker-cli
RUN apk update && apk add --no-cache \
    curl \
    docker-cli

RUN curl -fsSL https://dl.dagger.io/dagger/install.sh | BIN_DIR=/bin sh

ADD ./entrypoint.sh /bin
RUN chmod +x /bin/entrypoint.sh

ENTRYPOINT ["/bin/entrypoint.sh"]
