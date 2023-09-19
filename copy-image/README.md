# Copy Image
CI plugin to copy container images from one repository to another.

Uses [Skopeo](https://github.com/containers/skopeo) which is a command line utility that performs various operations on container images and image repositories.

# Commands to Build
```docker build -t copy-image .```

# Commands to Run
```docker run --rm --env-file ./.env copy-image```

# Usage

Set the following environment variables:

```
PLUGIN_SOURCE=konrness/debug:latest
PLUGIN_DEST=konrness/debug:latest-copy

PLUGIN_SOURCE_USER=
PLUGIN_SOURCE_PASS=
PLUGIN_DEST_USER=
PLUGIN_DEST_PASS=

PLUGIN_DEBUG=true
```