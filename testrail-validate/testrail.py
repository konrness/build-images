import os
import sys
import math

from datetime import datetime

from testrail_api import TestRailAPI

api = TestRailAPI()

run_id = os.getenv('PLUGIN_RUN_ID')
failed_status_id = int(os.getenv('PLUGIN_FAILED_STATUS_ID', 8))
fail_on_priority = int(os.getenv('PLUGIN_FAIL_ON_PRIORITY', 3))
debug = (os.getenv('PLUGIN_DEBUG', "false") == "true")

run   = api.runs.get_run(run_id=run_id)
tests = api.tests.get_tests(run_id=run_id)

pass_count = run["passed_count"]
total_count = tests["size"]
pass_rate = math.ceil(pass_count / total_count * 100)

print("runID:", run_id)
print("count of test case:", total_count)
print(pass_count, "Passed")
print("pass rate:", pass_rate)
print()

## TODO: Store run id and pass rate to pipeline variable

# Count priorities by test
failCount = 0
for test in tests["tests"]:
  if int(test["status_id"]) == failed_status_id:
    print("case_id:", test["case_id"], "title:", test["title"], "priority:", test["priority_id"], "status: failed")
    if int(test["priority_id"]) >= fail_on_priority:
      failCount += 1
    
if failCount > 0:
  print()
  print("There have been", failCount, "high/critical priority failed cases, please check.")
  sys.exit(1)
