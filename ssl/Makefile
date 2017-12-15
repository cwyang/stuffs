CC=gcc
CFLAGS=-I. -g
DEPS=
%.o: %c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

ecdsa_sig: ecdsa_sig.o
	$(CC) -o $@ $^ $(CFLAGS) -lssl -lcrypto
