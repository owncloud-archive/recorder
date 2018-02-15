#!/usr/bin/env bash
set -eo pipefail
[[ "${PLUGIN_DEBUG}" == "true" ]] && set -x

declare -x PLUGIN_HOSTNAME

# optional variables
declare -x PLUGIN_PASSWORD

# optional with defaults

declare -x PLUGIN_PORT
[[ -z "${PLUGIN_PORT}" ]] && PLUGIN_PORT="5900"

declare -x PLUGIN_FILENAME
[[ -z "${PLUGIN_FILENAME}" ]] && PLUGIN_FILENAME="${DRONE_REPO_OWNER}-${DRONE_REPO_NAME}-${DRONE_BUILD_NUMBER}-${DRONE_JOB_NUMBER}.flv"

declare -x PLUGIN_OUTPUT_PATH
[[ -z "${PLUGIN_OUTPUT_PATH}" ]] && PLUGIN_OUTPUT_PATH="${DRONE_WORKSPACE}/recorder"

declare -x PLUGIN_PASSWORD_FILE
[[ -z "${PLUGIN_PASSWORD_FILE}" ]] && PLUGIN_PASSWORD_FILE="/.vncpass"


plugin_main() {

    if [[ -z "${PLUGIN_HOSTNAME}" ]]; then
      echo "Missing hostname to establish connection to";
      exit 1;
    fi

    wfi -host="${PLUGIN_HOSTNAME}" -port="${PLUGIN_PORT}" -timeout=60

    if [[ ! -d "${PLUGIN_OUTPUT_PATH}" ]]; then
        mkdir -p "${PLUGIN_OUTPUT_PATH}"
    fi


    if [[ -z "${PLUGIN_PASSWORD}" ]]; then

        echo "$ flvrec.py -o ${PLUGIN_OUTPUT_PATH}/${PLUGIN_FILENAME} ${PLUGIN_HOSTNAME} ${PLUGIN_PORT}"
        flvrec.py -o "${PLUGIN_OUTPUT_PATH}/${PLUGIN_FILENAME}" "${PLUGIN_HOSTNAME}" "${PLUGIN_PORT}"
    else

        echo "${PLUGIN_PASSWORD}" > "${PLUGIN_PASSWORD_FILE}"
        echo "$ flvrec.py -N -o ${PLUGIN_OUTPUT_PATH}/${PLUGIN_FILENAME} -P ${PLUGIN_PASSWORD_FILE} ${PLUGIN_HOSTNAME} ${PLUGIN_PORT}"
        flvrec.py -N -o "${PLUGIN_OUTPUT_PATH}/${PLUGIN_FILENAME}" -P "${PLUGIN_PASSWORD_FILE}" "${PLUGIN_HOSTNAME}" "${PLUGIN_PORT}"
    fi

}

plugin_main