#include <openssl/ecdsa.h>
#include <openssl/ssl.h>
#include <openssl/err.h>
#include <openssl/bn.h>
#include <stdio.h>
/*
        struct
               {
               BIGNUM *r;
               BIGNUM *s;
        } ECDSA_SIG;
*/
const char *org_der = "3064023057d9e4734cd88b389d65f994afdd4676b355fb1ea968321f36eafc57c4057c63ac00ee9f0c64c583d2b64b6a6ede5ddf023084e1b5267ef16a9af924d6d2049f049b3e7997ae0edb64b1345339c84d4d688a1f6877968ebf4266dcd969b4482cf324";
const char *org_der2 = "3064023057d9e4734cd88b389d65f994afdd4676b355fb1ea968321f36eafc57c4057c63ac00ee9f0c64c583d2b64b6a6ede5ddf02307e75b3729276af8eeb0325fe2a8cab3a629c79206642225c6331edfefb3f3392bef95b0b65637ceb3d0b150d9861cb10";
const char *org_der3="30060201100201f0";

static char *read_der(const unsigned char *c, unsigned char *buf, size_t *buflen) 
{
    unsigned int ch;
    size_t len = 0;
    
    for (; *c != '\0'; c+=2) {
        if (*c >= 'a')
            ch = *c - 'a' + 10;
        else
            ch = *c - '0';
        ch *= 16;
        if (*(c+1) >= 'a')
            ch += *(c+1) - 'a' + 10;
        else
            ch += *(c+1) - '0';
        buf[len++] = ch;
    }
    *buflen=len;
    
    return buf;
}
static char *write_der(const unsigned char *der, size_t derlen, char *buf) 
{
    int i;
    for (i = 0; i < derlen; i++)
        sprintf(&buf[i*2], "%02x", der[i]);
    buf[i*2] = '\0';
    return buf;
}

static void test(const char *s) 
{
    char *c;
    char der[1000], new_der[1000], new_der2[1000];
    const unsigned char *pp = der;
    unsigned char *qq, *org_qq;
    ECDSA_SIG *a=NULL, *b=NULL;
    size_t derlen = 0, len2;
    
    read_der(s, der, &derlen);
    write_der(der, derlen, new_der);
    printf("ORG=[%s], len=%zu\n", new_der, derlen);
    
    a = ECDSA_SIG_new();
    b = d2i_ECDSA_SIG(&a, &pp, derlen);

    printf("a->r=");
    BN_print_fp(stdout, a->r);
    printf("\na->s=");
    BN_print_fp(stdout, a->s);
    printf("\n");    
    
    org_qq = qq = malloc(10000);
    len2 = i2d_ECDSA_SIG(a, &qq);
    write_der(org_qq, len2, new_der);
    printf("NEW=[%s], len=%zu\n", new_der, len2);

    b = d2i_ECDSA_SIG(&a, &org_qq, len2);
    printf("a->r=");
    BN_print_fp(stdout, a->r);
    printf("\na->s=");
    BN_print_fp(stdout, a->s);
    printf("\n");    

    org_qq = qq = malloc(10000);
    len2 = i2d_ECDSA_SIG(a, &qq);
    write_der(org_qq, len2, new_der);
    printf("NEW=[%s], len=%zu\n", new_der, len2);
}

static bn_test() 
{
    BIGNUM *bn=NULL;

    BN_hex2bn(&bn, "10");
    printf("10=");
    BN_print_fp(stdout, bn);
    bn=NULL;
    
    BN_hex2bn(&bn, "-10");
    printf("\n-10=");
    BN_print_fp(stdout, bn);
    printf("\n=");
}

void main() {
    SSL_load_error_strings();
    SSL_library_init();

    bn_test();
    
    test(org_der);
    
    printf("\n");
    
    test(org_der2);
    test(org_der3);
}
