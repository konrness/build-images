# Wiz To Harness STO Data Conversion Plugin
CI plugin to convert Wiz security scan JSON data to a format that Harness STO can ingest.

## Usage in Harness
Image: konrness/wiz-to-harness

Settings:
 - input_file - path to Wiz output JSON file
 - output_file - path to Harness STO JSON file
 - debug - true or false

## Usage in Docker
```
node /home/wizToHarness.js /harness/wizoriginal.json /harness/wizharness.json
```

## Docker Build
```
docker build -t wiz-to-harness .
```

## Test
```
docker run --rm --env-file ./.env -v $(pwd)/tests:/home/tests wiz-to-harness
```

## Related Docs: 
 - Wiz JSON format - TBD
 - Harness Custom Data Ingest - https://docs.harness.io/article/ymkcm5lypf

