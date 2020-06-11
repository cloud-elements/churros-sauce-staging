#!/bin/bash

case "$1" in
  snapshot|snp)
    echo 'Initializing churros to run tests against snapshot...'
    churros init --user 'churros@churros.com' --password 'elements1' --url 'https://snapshot.cloud-elements.com' --template ~/cloud-elements/churros-sauce/sauce.json --1pass --1pass-element all
  ;;
  staging|stg)
    echo 'Initializing churros to run tests against staging...'
    churros init --user 'churros@churros.com' --password 'elements1' --url 'https://staging.cloud-elements.com' --template ~/cloud-elements/churros-sauce-staging/sauce.json --1pass --1pass-element all
  ;;
  production|prod)
    echo 'Initializing churros to run tests against production...'
    churros init --user 'churros@churros.com' --password 'elements1' --url 'https://api.cloud-elements.com' --template ~/cloud-elements/churros-sauce-staging/sauce.json --1pass --1pass-element all
  ;;
  *)
    echo "Unrecognized or blank environment provided: $1. Churros will not be initialized."
  ;;
esac
