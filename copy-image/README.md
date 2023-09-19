# Copy Image
CI plugin to copy container images from one repository to another.

Uses [Skopeo](https://github.com/containers/skopeo) which is a command line utility that performs various operations on container images and image repositories.

# Configuration

The following parameters are used to configure the plugin:
 
 - `source`: The source image. Must follow the image name format described in the Skopeo docs. Required.
 - `dest`: The destination image. Must follow the image name format described in the Skopeo docs. Required.
 - `source_user`: Username credential for the source registry. Required.
 - `source_password`: Password credential for the source registry. Required.
 - `dest_user`: Username credential for the destination registry. Required.
 - `dest_password`: Password credential for the destination registry. Required.
 - `debug`: Set to `true` for debugging. Optional.

## Harness configuration example

```
pipeline:
  stages:
    - stage:
      spec:
        execution:
          steps:
            - step:
                type: Plugin
                name: Copy Container Image
                identifier: Copy_Container_Image
                spec:
                  connectorRef: konrness_Docker_Hub
                  image: konrness/copy-image
                  settings:
                    source: docker://docker.io/konrness/debug:latest
                    dest: docker://docker.io/konrness/debug:latest-copy
                    source_user: konrness
                    source_pass: <+secrets.getValue("konrness_DockerHub")>
                    dest_user: konrness
                    dest_pass: <+secrets.getValue("konrness_DockerHub")>
```

# Commands to Build
```docker build -t copy-image .```

# Commands to Run
```docker run --rm --env-file ./.env copy-image```

# Command Line Usage
Set the following environment variables in an `.env` file:

```
PLUGIN_SOURCE=docker://docker.io/konrness/debug:latest
PLUGIN_DEST=docker://docker.io/konrness/debug:latest-copy

PLUGIN_SOURCE_USER=
PLUGIN_SOURCE_PASS=
PLUGIN_DEST_USER=
PLUGIN_DEST_PASS=

PLUGIN_DEBUG=true
```