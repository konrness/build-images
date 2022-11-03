FROM node:18-alpine3.15

LABEL maintainer="konrness@gmail.com"
LABEL source="https://github.com/konrness/build-images"

WORKDIR /bin

ADD ./entrypoint.sh /bin
RUN chmod +x /bin/entrypoint.sh

ADD ./kicsToHarness.js /home/kicsToHarness.js

ENTRYPOINT ["entrypoint.sh"]