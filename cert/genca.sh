MYDIR=$(pwd -P)
WORKDIR=./ca
BASEDIR=./

mkdir -pv $WORKDIR
cd $WORKDIR

mkdir -pv private
chmod g-rwx,o-rwx private
mkdir -pv certs
touch index.txt
echo '01' > serial

DEFAULT_STARTDATE=$(date +'%y%m01000000Z')

cat <<EOF >openssl.cnf
[ ca ]
default_ca = my_test_ca

[ my_test_ca ]
certificate       = $BASEDIR/cacert.pem
database          = $BASEDIR/index.txt
new_certs_dir     = $BASEDIR/certs
private_key       = $BASEDIR/private/cakey.pem
serial            = $BASEDIR/serial

default_crl_days  = 7
default_days      = 356
default_md        = md5
default_startdate = $DEFAULT_STARTDATE

policy            = my_test_ca_policy
x509_extensions   = certificate_extensions

[ my_test_ca_policy ]
commonName              = supplied
stateOrProvinceName     = supplied
countryName             = supplied
emailAddress            = supplied
organizationName        = supplied
organizationalUnitName  = optional

[ certificate_extensions ]
basicConstraints  = CA:false

[ req ]
default_bits      = 2048
default_keyfile   = $BASEDIR/private/cakey.pem
default_md        = md5
default_startdate = $DEFAULT_STARTDATE
default_days      = 356

prompt              = no
distinguished_name  = root_ca_distinguished_name
x509_extensions     = root_ca_extensions

[ root_ca_distinguished_name ]
commonName           = TEST CA
stateOrProvinceName  = ARA
countryName          = KR
emailAddress         = cwyang@aranetworks.com
organizationName     = ARATECH

[ root_ca_extensions ]
basicConstraints = CA:true

EOF


# Now generate self-signed certificate and generate key pair to go with it...
OPENSSL_CONF=./openssl.cnf openssl req -nodes -x509 -newkey rsa:2048 -out cacert.pem -outform PEM -verbose
