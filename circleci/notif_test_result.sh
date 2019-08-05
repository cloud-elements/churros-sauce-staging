#!/usr/bin/env bash
set -xe

#
# script to send notifications and stopandfix flag based on test results
# - required that stopandfix binary is at ~/stopandfix and slack-cli binary at ~/slack-cli/src/slack
#

NOTIF_CHANNEL_QA='#staging-stop-and-fix'
STOPNFIX=0

# gather context
if [ "$1" != "PASS" ] && [ "$1" != "FAIL" ]; then
  echo "first argument must be either 'PASS' or 'FAIL'" && exit 1
fi
PASS_OR_FAIL=$1

[ -z "$2" ] && echo "missing second argument used for environment (i.e. snp)" && exit 1
ENVIRONMENT=$2

[ -z "$3" ] && echo "missing third argument used for test name (i.e. churros)" && exit 1
TEST_NAME=$3

[ -z "$4" ] && echo "missing fourth argument used for user (i.e. circleci)" && exit 1
USER=$4

if [ -z "$5" ]
then
  # If not present then, we're checking per #stopandfix
  STOPNFIX=1
else
  NOTIF_CHANNEL_QA='#el-provisioning-test'
  STOPNFIX=0
fi

if [ ${PASS_OR_FAIL} == "PASS" ]
then
  ~/slack-cli/src/slack chat send --channel "${NOTIF_CHANNEL_QA}" --color good --text "*${TEST_NAME}* tests were successful :tada:" -flds "{\"title\": \"Environment\", \"value\": \"${ENVIRONMENT}\", \"short\": true}" -a "{\"type\": \"button\", \"style\": \"primary\", \"text\": \"See results :mag_right:\", \"url\": \"${CIRCLE_BUILD_URL}\"}"
else
  ~/slack-cli/src/slack chat send --channel "${NOTIF_CHANNEL_QA}" --color danger --text "*${TEST_NAME}* tests failed! :no_entry:" -flds "{\"title\": \"Environment\", \"value\": \"${ENVIRONMENT}\", \"short\": true}" -a '{"type": "button", "style": "primary", "text": "See results :mag_right:", "url": "'"${CIRCLE_BUILD_URL}"'"}'
  [[ ${STOPNFIX} == 1 ]] && ~/stopandfix upsert -t 'test' -s ${TEST_NAME} -e ${ENVIRONMENT} -u 'circleci'
fi
