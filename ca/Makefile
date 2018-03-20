#
# CA makefile
# 20 Mar 2018
# Chul-Woong Yang
#

PREPARE_DIRECTORY	=./prepare_directory.sh
PREPARE_ROOTCA_DIR	= $(PREPARE_DIRECTORY) root-ca
PREPARE_SUBCA_DIR	= $(PREPARE_DIRECTORY) sub-ca
GEN_CA			=./gen_ca.sh
GEN_CERT		=./gen_cert.sh
GEN_CRL			=./gen_crl.sh
GEN_OCSP		=./gen_ocsp.sh
GEN_ROOTCA		= $(GEN_CA) root-ca
GEN_SUBCA		= $(GEN_CA) sub-ca
GEN_ROOTCRL		= $(GEN_CRL) root-ca
GEN_SUBCRL		= $(GEN_CRL) sub-ca
# CERTNAME should be set as make CERTNAME=foo server_from_root
GEN_SERVER_FROM_ROOT	= $(GEN_CERT) $(CERTNAME) server root-ca.conf
GEN_CLIENT_FROM_ROOT	= $(GEN_CERT) $(CERTNAME) client root-ca.conf
GEN_SERVER_FROM_SUB	= $(GEN_CERT) $(CERTNAME) server sub-ca.conf
GEN_CLIENT_FROM_SUB	= $(GEN_CERT) $(CERTNAME) client sub-ca.conf
RUN_REVOKE		=./run_revoke.sh
RUN_ROOTREVOKE		= $(RUN_REVOKE) root-ca
RUN_SUBREVOKE		= $(RUN_REVOKE) sub-ca

ROOTCA_CONF	=./root-ca.conf
ROOTCA_DIR	=root-ca
ROOTCERT	=root-ca.crt
SUBCA_CONF	=./sub-ca.conf
SUBCA_DIR	=sub-ca
SUBCERT		=sub-ca.crt

.PHONY: all prepare rootca subca clean rootcrl subcrl rootrevoke subrevoke ocsp
.PHONY: server_from_root server_from_sub
.PHONY: client_from_root client_from_sub

help:
	@echo "Usage: make [ all | help | clean ]"
	@echo "            [ rootca | subca | rootcrl | subcrl | ocsp ]"
	@echo "            [ PEM=cert/foo.pem rootrevoke   | .. subrevoke ]"
	@echo "            [ CERTNAME=foo server_from_root | .. server_from_sub ]"
	@echo "            [ CERTNAME=foo client_from_root | .. client_from_sub ]"

all: prepare
	echo Hi

clean:
	rm $(ROOTCA_DIR)/$(ROOTCERT)
	rm $(SUBCA_DIR)/$(SUBCERT)
###
prepare: $(ROOTCA_DIR)/$(ROOTCA_CONF) $(SUBCA_DIR)/$(SUBCA_CONF)

$(ROOTCA_DIR)/$(ROOTCA_CONF): $(ROOTCA_CONF)
	$(PREPARE_ROOTCA_DIR)
	cp $(ROOTCA_CONF) $(ROOTCA_DIR)

$(SUBCA_DIR)/$(SUBCA_CONF): $(SUBCA_CONF) $(ROOTCA_CONF)
	$(PREPARE_SUBCA_DIR)
	cp $(ROOTCA_CONF) $(SUBCA_DIR)
	cp $(SUBCA_CONF) $(SUBCA_DIR)
###
rootca: $(ROOTCA_DIR)/$(ROOTCERT)

$(ROOTCA_DIR)/$(ROOTCERT):
	cd $(ROOTCA_DIR) && \
	../$(GEN_ROOTCA)
###
subca: $(SUBCA_DIR)/$(SUBCERT)

$(SUBCA_DIR)/$(SUBCERT):
	cd $(SUBCA_DIR) && \
	../$(GEN_SUBCA) && \
	cat sub-ca.crt ../root-ca/root-ca.crt > sub-ca.pem
###
rootcrl:
	cd $(ROOTCA_DIR) && \
	../$(GEN_ROOTCRL)
subcrl:
	cd $(SUBCA_DIR) && \
	../$(GEN_SUBCRL)
###
rootrevoke:
	cd $(ROOTCA_DIR) && \
	../$(RUN_ROOTREVOKE) $(PEM)
subrevoke:
	cd $(SUBCA_DIR) && \
	../$(RUN_SUBREVOKE) $(PEM)
###
server_from_root:
	cd $(ROOTCA_DIR) && \
	../$(GEN_SERVER_FROM_ROOT) && \
	cat certs/${CERTNAME}.crt root-ca.crt > certs/${CERTNAME}.pem
server_from_sub:
	cd $(SUBCA_DIR) && \
	../$(GEN_SERVER_FROM_SUB) && \
	cat certs/${CERTNAME}.crt sub-ca.pem > certs/${CERTNAME}.pem
client_from_root:
	cd $(ROOTCA_DIR) && \
	../$(GEN_CLIENT_FROM_ROOT) && \
	cat certs/${CERTNAME}.crt root-ca.crt > certs/${CERTNAME}.pem
client_from_sub:
	cd $(SUBCA_DIR) && \
	../$(GEN_CLIENT_FROM_SUB) && \
	cat certs/${CERTNAME}.crt sub-ca.pem > certs/${CERTNAME}.pem
###
ocsp:
	cd $(ROOTCA_DIR) && \
	../$(GEN_OCSP)
