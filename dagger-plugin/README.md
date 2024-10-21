# Dagger.io Drone Plugin
CI plugin to run Dagger modules in Harness/Drone CI

# Commands to Build
```docker build -t dagger-plugin .```

# Commands to Run
```docker run --rm --env-file ./.env -v $(pwd):/tmp dagger-plugin```