#!/bin/bash -f
# Generate key and CSR
TARGET=$1 #root-ca | sub-ca
EXT=${TARGET/-/_}
NOTEXT=-notext

echo "Creating $TARGET ca certificate with extension $EXT"

openssl req -new -config ${TARGET}.conf \
	-out ${TARGET}.csr -keyout private/${TARGET}.key
RES=$?

if [ "$RES" -ne 0 ]; then
    echo "previous operation failed with error code $RES"
    exit 1
fi

# Create self-signed cert
if [ "$TARGET" == "root-ca" ]; then
    openssl ca -selfsign -config root-ca.conf \
	    -in ${TARGET}.csr -out ${TARGET}.crt \
	    ${NOTEXT} -extensions ${EXT}_ext
else
    openssl ca -config root-ca.conf \
	    -in ${TARGET}.csr -out ${TARGET}.crt \
	    -keyfile ../root-ca/private/root-ca.key \
	    -cert ../root-ca/root-ca.crt \
	    ${NOTEXT} -extensions ${EXT}_ext
fi
