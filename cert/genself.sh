#!/bin/bash
SERVERRSA=$1
KEYBIT=$2
SCN=$3
SDOMAIN=$4

if [ "${SERVERRSA}" == "1" ]; then
    openssl genpkey -algorithm RSA -out server_key.pem -pkeyopt rsa_keygen_bits:${KEYBIT} -aes128
    SCNAME=${SCN}
else
    openssl ecparam -genkey -name secp256r1 | openssl ec -out server_key.pem -aes128 #256bit
    SCNAME="[EC]${SCN}"
fi
openssl req -new -key server_key.pem -days 1096 -extensions v3_ca -batch -out server.csr -utf8 -subj "/CN=${SCNAME}"
openssl x509 -req -sha256 -days 1096 -in server.csr -signkey server_key.pem -set_serial ${RANDOM} -out server_cert.pem \
    -extfile <(cat server.cnf \
    <(printf "subjectAltName=DNS:${SDOMAIN}
"))

cat server_key.pem server_cert.pem > server.crt
