#!/bin/bash -f
NAME=$1
TARGET=$2
CONF=$3
NOTEXT=-notext

if [ "$#" -ne 3 ]; then
    echo "Usage: gen_cert_ec.sh [NAME] [TARGET] [CONF]"
    exit 1
fi
echo "Creating $TARGET EC certificate '$NAME' with configuration $2"
 -x509 -nodes -newkey ec:<(openssl ecparam -name secp384r1) -keyout cert.key -out cert.crt -days 3650

openssl req -new \
	-out csr/${NAME}.csr \
	-newkey ec:<(openssl ecparam -name secp384r1) \
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
