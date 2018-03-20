#!/bin/bash -f
# Generate key and CSR
openssl req -new -config sub-ca.conf \
	-out root-ca.csr -keyout private/root-ca.key

RES=$?
if [ "$RES" -ne 0 ]; then
    echo "previous operation failed with error code $RES"
    exit 1
fi

# Create self-signed cert
openssl ca -selfsign -config root-ca.conf \
	-in root-ca.csr -out root-ca.crt \
	-extensions ca_ext
