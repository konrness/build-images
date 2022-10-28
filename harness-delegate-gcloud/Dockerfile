FROM harness/delegate:latest

LABEL maintainer="konrness@gmail.com"
LABEL source="https://github.com/konrness/build-images"

# See https://cloud.google.com/sdk/docs/install#deb
USER 0
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && apt-get update -y && apt-get install google-cloud-cli -y
USER 1001
