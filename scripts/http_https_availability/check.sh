#!/bin/bash

URL_PART=$1
DOMAIN_EXTENSION=$2

URL=http://${URL_PART}.${DOMAIN_EXTENSION}
URLS=https://${URL_PART}.${DOMAIN_EXTENSION}
PRINT_INFO=""

HTTPS_RETURN_CODE=`curl -o /dev/null -m60 -sk -w "%{http_code}\n" ${URLS}`; [ ${HTTPS_RETURN_CODE} -ne "000" ] && PRINT_INFO="[${URLS} ${HTTPS_RETURN_CODE}]"

curl -o /dev/null -m60 -sk -w "${URL_PART} ${URL} [%{http_code}] -> %{redirect_url} $PRINT_INFO\n" ${URL}

