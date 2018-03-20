#!/bin/bash -f
NOTEXT=-notext

openssl req -new \
	-newkey rsa:2048 \
	-subj "/C=KR/O=cwyang/CN=cwyang's Test OCSP Root Responder" \
	-keyout private/root-ocsp.key \
	-out root-ocsp.csr
RES=$?
if [ "$RES" -ne 0 ]; then
    echo "previous operation failed with error code $RES"
    exit 1
fi
openssl ca -config root-ca.conf \
	-in root-ocsp.csr \
	-out root-ocsp.crt \
	-extensions ocsp_ext \
	-days 30 \
	${NOTEXT}
RES=$?
if [ "$RES" -ne 0 ]; then
    echo "previous operation failed with error code $RES"
    exit 1
fi
