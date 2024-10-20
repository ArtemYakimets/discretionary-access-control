#! /bin/bash

GITHUB_IS_GITHUB="${1}"
GITHUB_DOT="."

TEMP_FILE="$(mktemp)"
APP="./build/my_chmod"
MESSAGE="not all tests pass."
ERROR_CODE=0

set_error() {
    >&2 echo ${1}
    ERROR_CODE=1
}

if [ -n "${GITHUB_IS_GITHUB}" ]; then
    GITHUB_DOT=""
fi

$APP 777 "${TEMP_FILE}" && [ "$(ls -l ${TEMP_FILE} | cut -d' ' -f1)" = "-rwxrwxrwx${GITHUB_DOT}" ] || set_error "error on input 777"
$APP 644 "${TEMP_FILE}" && [ "$(ls -l ${TEMP_FILE} | cut -d' ' -f1)" = "-rw-r--r--${GITHUB_DOT}" ] || set_error "error on input 644"
$APP 7777 "${TEMP_FILE}" && [ "$(ls -l ${TEMP_FILE} | cut -d' ' -f1)" = "-rwsrwsrwt${GITHUB_DOT}" ] || set_error "error on input 7777"
$APP 7757 "${TEMP_FILE}" && [ "$(ls -l ${TEMP_FILE} | cut -d' ' -f1)" = "-rwsr-srwt${GITHUB_DOT}" ] || set_error "error on input 7757"
$APP 1234 "${TEMP_FILE}" && [ "$(ls -l ${TEMP_FILE} | cut -d' ' -f1)" = "--w--wxr-T${GITHUB_DOT}" ] || set_error "error on input 7757"
$APP 77777 "${TEMP_FILE}" 1>/dev/null 2>/dev/null && set_error "not enough validation: input 77777"
$APP 8 "${TEMP_FILE}" 1>/dev/null 2>/dev/null && set_error "not enough validation: input 8"

rm "${TEMP_FILE}"

exit "${ERROR_CODE}"
