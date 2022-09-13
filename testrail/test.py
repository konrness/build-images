"""
@see https://pypi.org/project/testrail-api/
@env TESTRAIL_URL=https://example.testrail.com/
@env TESTRAIL_EMAIL=example@mail.com
@env TESTRAIL_PASSWORD=password
"""
from testrail_api import TestRailAPI

api = TestRailAPI()

new_milestone = api.milestones.get_milestones(
    project_id=1
)
