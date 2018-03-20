#!/bin/bash -f
TARGET=$1
openssl ca -config ${TARGET}.conf -crl_reason unspecified -revoke $*
