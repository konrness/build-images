FROM quay.io/skopeo/stable:latest

LABEL maintainer="konrness@gmail.com"
LABEL source="https://github.com/konrness/build-images"

ADD ./entrypoint.sh /usr/bin
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["/usr/bin/entrypoint.sh"]