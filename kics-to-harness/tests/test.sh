node /home/kicsToHarness.js kics.json output.json

echo "Output:"

cat output.json

echo "\nExpected:"

cat expected.json

if cmp -s "output.json" "expected.json"; then
  echo "\n\nPASS -- The two files match. "
  exit 0
else
  echo "\n\nFAIL -- The two files do not match."
  exit 1
fi