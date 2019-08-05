#!/usr/bin/env bash

set -xe

TESTS_PASS_TAG="us-west-2_staging_tests_pass"
DEPLOYED_TAG="us-west-2_staging_deployed"

# set the snapshot_tests_pass tag
git clone https://github.com/cloud-elements/soba.git ~/soba
pushd ~/soba

VERSION_TAG=$(git tag -l -n1 origin ${DEPLOYED_TAG} | awk '{print $2}')
if [ -z $VERSION_TAG ]; then
  echo "Unable to find the version from the soba ${DEPLOYED_TAG} git tag"
  exit 1
fi

git checkout $VERSION_TAG
git tag -a -f -m $VERSION_TAG $TESTS_PASS_TAG
git push -f origin $TESTS_PASS_TAG

~/slack-cli/src/slack chat send --channel '#staging-stop-and-fix' --color good --text "All *Staging Test* tests were successful, set tag ${TESTS_PASS_TAG} to ${VERSION_TAG} :tada:" -flds "{\"title\": \"Environment\", \"value\": \"Snapshot\", \"short\": true}" -a "{\"type\": \"button\", \"style\": \"primary\", \"text\": \"See results :mag_right:\", \"url\": \"${CIRCLE_BUILD_URL}\"}"

popd


