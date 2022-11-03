# Wiz To Harness STO Data Conversion Plugin
CI plugin to convert Wiz security scan JSON data to a format that Harness STO can ingest.

## Usage
```
node /home/wizToHarness.js /harness/wizoriginal.json /harness/wizharness.json
```

## Test
```
docker run --rm --env-file ./.env -v $(pwd)/tests:/home/tests wiz-to-harness
```

## Related Docs: 
 - Wiz JSON format - TBD
 - Harness Custom Data Ingest - https://docs.harness.io/article/ymkcm5lypf

