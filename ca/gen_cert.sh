#!/bin/bash -f
NAME=$1
TARGET=$2
CONF=$3
NOTEXT=-notext

if [ "$#" -ne 3 ]; then
    echo "Usage: gen_cert.sh [NAME] [TARGET] [CONF]"
    exit 1
fi
echo "Creating $TARGET certificate '$NAME' with configuration $2"
openssl req -new \
	-out csr/${NAME}.csr \
	-keyout private/${NAME}.key \
	-config <(grep -v prompt ${CONF}|sed 's/[^\[]ca_dn/req_dn/')
RES=$?
if [ "$RES" -ne 0 ]; then
    echo "previous operation failed with error code $RES"
    exit 1
fi
openssl ca -config ${CONF} \
	-in csr/${NAME}.csr \
	-out certs/${NAME}.crt \
	${NOTEXT} -extensions ${TARGET}_ext
RES=$?
if [ "$RES" -ne 0 ]; then
    echo "previous operation failed with error code $RES"
    exit 1
fi
