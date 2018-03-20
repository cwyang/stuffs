#!/bin/bash -f
DIR=$1
mkdir ${DIR}
cd ${DIR}
mkdir certs db private csr
chmod 700 private
touch db/index
openssl rand -hex 16 > db/serial
echo 1001 > db/crlnumber
touch README
