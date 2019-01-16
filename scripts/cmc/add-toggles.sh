#!/usr/bin/env sh

if [ ! -z "$VERBOSE" ] && [ -e "$VERBOSE" ]; then
  export CURL_OPTS="-v"
else
  export CURL_OPTS="--fail --silent"
fi

function add_weighted_toggle() {
  export WEIGHTED_TOGGLE_NAME="${1}"
  export DESCRIPTION="${2}"
  export WEIGHT="${3}"

  echo -e "${FEATURE_TOGGLE_API_URL} ::: adding ${WEIGHTED_TOGGLE_NAME} with weight ${WEIGHT} and ${DESCRIPTION}"

  envsubst < /weighted_toggle.template.json > /"${WEIGHTED_TOGGLE_NAME}".json

  curl ${CURL_OPTS} -X PUT \
   -H 'Content-Type: application/json' \
   -u admin@example.com:Password12 \
   -d @/"${WEIGHTED_TOGGLE_NAME}".json \
   "${FEATURE_TOGGLE_API_URL}""${WEIGHTED_TOGGLE_NAME}"
}

function add_toggle() {
  export TOGGLE_NAME="${1}"
  export DESCRIPTION="${2}"
  export TOGGLE_ENABLED="${3}"

  echo -e "Setting ${TOGGLE_NAME} to ${TOGGLE_ENABLED}"

  envsubst < /toggle.template.json > /"${TOGGLE_NAME}".json

  curl ${CURL_OPTS} -X PUT \
   -H 'Content-Type: application/json' \
   -u admin@example.com:Password12 \
   -d @/"${TOGGLE_NAME}".json \
   "${FEATURE_TOGGLE_API_URL}""${TOGGLE_NAME}"
}

add_weighted_toggle cmc_admissions 'CMC admissions' '1.0'
add_toggle cmc_defence_reminders 'CMC defence reminders' false