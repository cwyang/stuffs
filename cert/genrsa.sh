openssl genpkey -algorithm RSA -out ca_key.pem -pkeyopt rsa_keygen_bits:2048
openssl req -new -key ca_key.pem -days 1096 -extensions v3_ca -batch -out ca.csr -utf8 -subj '/CN=CWYANG_TEST_CA'
openssl x509 -req -sha256 -days 3650 -in ca.csr -signkey ca_key.pem -set_serial 1111 -extfile ca.cnf -out ca_cert.pem

openssl genpkey -algorithm RSA -out server_key.pem -pkeyopt rsa_keygen_bits:2048
openssl req -new -key server_key.pem -days 1096 -extensions v3_ca -batch -out server.csr -utf8 -subj '/CN=CWYANG_TEST_SERVER'
openssl x509 -req -sha256 -days 1096 -in ca.csr -CAkey ca_key.pem -CA ca_cert.pem -set_serial 2222 -out server_cert.pem -extfile server.cnf

cat server_key.pem server_cert.pem ca_cert.pem > server.crt
