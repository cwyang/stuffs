#!/bin/bash -f
TARGET=$1
CERTNAME=$2
openssl ca -config ${TARGET}.conf -crl_reason unspecified -revoke ${CERTNAME}
