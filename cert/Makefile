KEYBIT=2048
SERVERDOMAIN="server.domain.com"
CADOMAIN="ca.domain.com"
SERVERCN="cwyang test server $(KEYBIT)"
CACN="cwyang test CA $(KEYBIT)"
GENRSA=./genrsa.sh
rsa: ca.cnf server.cnf $(GENRSA)
	$(GENRSA) 1 1 $(KEYBIT) $(SERVERCN) $(CACN) $(SERVERDOMAIN) $(CADOMAIN)
ee: ca.cnf server.cnf $(GENRSA)
	$(GENRSA) 0 0 $(KEYBIT) $(SERVERCN) $(CACN) $(SERVERDOMAIN) $(CADOMAIN)
re: ca.cnf server.cnf $(GENRSA)
	$(GENRSA) 0 1 $(KEYBIT) $(SERVERCN) $(CACN) $(SERVERDOMAIN) $(CADOMAIN)
er: ca.cnf server.cnf $(GENRSA)
	$(GENRSA) 1 0 $(KEYBIT) $(SERVERCN) $(CACN) $(SERVERDOMAIN) $(CADOMAIN)
