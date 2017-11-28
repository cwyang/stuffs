#!/bin/bash -f
# generate RSA 2048
./genrsa.sh 1 1 2048 rsa-server rsa-ca rsa-server.com rsa-ca.com
mv server.crt rsa.pem
# generate RSA 2048
./genrsa.sh 0 0 2048 ec-server ec-ca ec-server.com ec-ca.com
mv server.crt ec.pem

