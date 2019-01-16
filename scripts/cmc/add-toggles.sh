#!/usr/bin/env sh

export JSON_DIR="/scripts/cmc/"
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

  envsubst < "${JSON_DIR}"weighted_toggle.template.json > "${JSON_DIR}""${WEIGHTED_TOGGLE_NAME}".json

  curl ${CURL_OPTS} -X PUT \
   -H 'Content-Type: application/json' \
   -u admin@example.com:Password12 \
   -d @"${JSON_DIR}""${WEIGHTED_TOGGLE_NAME}".json \
   "${FEATURE_TOGGLE_API_URL}""${WEIGHTED_TOGGLE_NAME}"
}

function add_toggle() {
  export TOGGLE_NAME="${1}"
  export DESCRIPTION="${2}"
  export TOGGLE_ENABLED="${3}"

  echo -e "Setting ${TOGGLE_NAME} to ${TOGGLE_ENABLED}"

  envsubst < "${JSON_DIR}"toggle.template.json > "${JSON_DIR}""${TOGGLE_NAME}".json

  curl ${CURL_OPTS} -X PUT \
   -H 'Content-Type: application/json' \
   -u admin@example.com:Password12 \
   -d @"${JSON_DIR}""${TOGGLE_NAME}".json \
   "${FEATURE_TOGGLE_API_URL}""${TOGGLE_NAME}"
}

echo -e "VERBOSE=${VERBOSE} ::: JSON_DIR=${JSON_DIR}"

add_weighted_toggle cmc_admissions 'CMC admissions' '1.0'
add_toggle cmc_defence_reminders 'CMC defence reminders' false