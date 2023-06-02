# Debug Drone/Harness Plugin
CI plugin to debug Drone Plugin inputs and environment variables


# Commands to Build
```docker build -t debug .```

# Commands to Run
```docker run --rm --env-file ./.env -v $(pwd):/tmp debug```