#!/usr/bin/env sh

if [ ! -z "$VERBOSE" ] && [ -e "$VERBOSE" ]; then
  export CURL_OPTS="-v"
else
  export CURL_OPTS="--fail --silent"
fi
export JSON_DIR="/scripts/"
export WEIGHTED_TOGGLE_NAME="${1}"
export DESCRIPTION="${2}"
export WEIGHT="${3}"

if [ "_${IMPORTER_CREDS_MOUNT}" != "_" ]; then
  echo "Getting credentials from vault"
  ADMIN_USERNAME=$(cat ${IMPORTER_CREDS_MOUNT}/admin-username-cmc)
  ADMIN_PASSWORD=$(cat ${IMPORTER_CREDS_MOUNT}/admin-password-cmc)
fi

echo -e "VERBOSE=${VERBOSE} ::: JSON_DIR=${JSON_DIR}"
echo -e "${FEATURE_TOGGLE_API_URL} ::: adding ${WEIGHTED_TOGGLE_NAME} with weight ${WEIGHT} and ${DESCRIPTION}"

envsubst < "${JSON_DIR}"weighted_toggle.template.json > "${JSON_DIR}""${WEIGHTED_TOGGLE_NAME}".json

curl ${CURL_OPTS} -X PUT \
  -H 'Content-Type: application/json' \
  -u "${ADMIN_USERNAME}":"${ADMIN_PASSWORD}" \
  -d @"${JSON_DIR}""${WEIGHTED_TOGGLE_NAME}".json \
  "${FEATURE_TOGGLE_API_URL}""${WEIGHTED_TOGGLE_NAME}"