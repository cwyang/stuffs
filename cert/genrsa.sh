#!/bin/bash
CARSA=$1
SERVERRSA=$2
KEYBIT=$3
SCN=$4
CCN=$5
SDOMAIN=$6
CDOMAIN=$7
if [ "${CARSA}" == "1" ]; then
    openssl genpkey -algorithm RSA -out ca_key.pem -pkeyopt rsa_keygen_bits:${KEYBIT}
    CCNAME=${CCN}
else
    openssl ecparam -genkey -name secp256r1 | openssl ec -out ca_key.pem #256bit
    CCNAME="[EC]${CCN}"
fi
openssl req -new -key ca_key.pem -days 1096 -extensions v3_ca -batch -out ca.csr -utf8 -subj "/CN=${CCNAME}"
openssl x509 -req -sha256 -days 3650 -in ca.csr -signkey ca_key.pem -set_serial 1111 -out ca_cert.pem \
    -extfile <(cat ca.cnf \
    <(printf "subjectAltName=DNS:${CDOMAIN}"))

if [ "${SERVERRSA}" == "1" ]; then
    openssl genpkey -algorithm RSA -out server_key.pem -pkeyopt rsa_keygen_bits:${KEYBIT}
    SCNAME=${SCN}
else
    openssl ecparam -genkey -name secp256r1 | openssl ec -out server_key.pem  #256bit
    SCNAME="[EC]${SCN}"
fi
openssl req -new -key server_key.pem -days 1096 -extensions v3_ca -batch -out server.csr -utf8 -subj "/CN=${SCNAME}"
openssl x509 -req -sha256 -days 1096 -in server.csr -CAkey ca_key.pem -CA ca_cert.pem -set_serial ${RANDOM} -out server_cert.pem \
    -extfile <(cat server.cnf \
    <(printf "subjectAltName=DNS:${SDOMAIN}
"))

cat server_key.pem server_cert.pem ca_cert.pem > server.crt
