# Kics To Harness STO Data Conversion Plugin
CI plugin to convert Kics security scan JSON data to a format that Harness STO can ingest.

## Usage in Harness
Image: konrness/kics-to-harness

Settings:
 - input_file - path to Kics output JSON file
 - output_file - path to Harness STO JSON file
 - debug - true or false

## Usage in Docker
```
node /home/kicsToHarness.js /harness/kicsoriginal.json /harness/kicsharness.json
```

## Test
```
docker build -t kics-to-harness .
docker run --rm --env-file ./.env -v $(pwd)/tests:/home/tests kics-to-harness
```

## Related Docs: 
 - KICS JSON format - https://docs.kics.io/latest/results/#json
 - Harness Custom Data Ingest - https://docs.harness.io/article/ymkcm5lypf

## To run a KICS Scan:

```
docker pull checkmarx/kics:latest
docker run -t -v $(pwd):/path checkmarx/kics scan -p /path -o "/path/"
```
