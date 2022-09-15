# build-images
Repository of Dockerfiles for creating build images used for Harness CI steps

# Commands to Build
```docker build -t testrail .```

# Commands to Run
```docker run --rm --env-file ./.env -v $(pwd)/tests:/usr/src/app/tests  testrail```