KEYBIT=2048
SERVERDOMAIN="ns.aratech.co.kr"
CADOMAIN="ca.aratech.co.kr"
SERVERCN="cwyang test server $(KEYBIT)"
CACN="cwyang test CA $(KEYBIT)"
GENRSA=./genrsa.sh
GENSELF=./genself.sh
rsa: ca.cnf server.cnf $(GENRSA)
	$(GENRSA) 1 1 $(KEYBIT) $(SERVERCN) $(CACN) $(SERVERDOMAIN) $(CADOMAIN)
ee: ca.cnf server.cnf $(GENRSA)
	$(GENRSA) 0 0 $(KEYBIT) $(SERVERCN) $(CACN) $(SERVERDOMAIN) $(CADOMAIN)
re: ca.cnf server.cnf $(GENRSA)
	$(GENRSA) 0 1 $(KEYBIT) $(SERVERCN) $(CACN) $(SERVERDOMAIN) $(CADOMAIN)
er: ca.cnf server.cnf $(GENRSA)
	$(GENRSA) 1 0 $(KEYBIT) $(SERVERCN) $(CACN) $(SERVERDOMAIN) $(CADOMAIN)
selfca: 
	openssl ca -config ca.cnf -selfsign -keyfile server_key.pem -out server.pem -startdate 20150214120000Z -enddate 20160214120000Z
self-pass:
	$(GENSELF) 1 $(KEYBIT) $(SERVERCN) $(SERVERDOMAIN)
