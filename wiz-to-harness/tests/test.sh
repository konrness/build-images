node /home/wizToHarness.js wiz.json output.json

echo "Output:"

cat output.json

echo "Expected:"

cat expected.json

if cmp -s "output.json" "expected.json"; then
  exit 0
else
  echo "The two files do not match."
  exit 1
fi