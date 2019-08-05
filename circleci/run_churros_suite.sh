#!/bin/bash

function usage {
  printf "\n\tUsage: ${0} <exclude_list> <test_name> [extra_param]\n\n"
  exit 1
}

if [ "$#" -lt 1 ] ; then usage ; fi


cd ~/cloud-elements/churros

case "$#" in
1)
  MOCHA_FILE="/tmp/circleci-test-results/mocha/${1}.xml" churros --reporter mocha-junit-reporter test "${1}"
;;
2)
  MOCHA_FILE="/tmp/circleci-test-results/mocha/${1}.xml" churros --reporter mocha-junit-reporter test "${1}" "${2}"
;;
*)
  usage
;;
esac
