#!/bin/bash -f
TARGET=$1
openssl ca -gencrl -config ${TARGET}.conf \
	-out ${TARGET}.crl
