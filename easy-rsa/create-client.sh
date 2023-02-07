#/bin/bash
set -e

if [ -z $EASYRSA_CLIENT_CN ]; then
  echo "EASYRSA_CLIENT_CN is not set"
  exit 1
fi

if [ -z $EASYRSA_OUTPUT_DIR ]; then
  EASYRSA_OUTPUT_DIR="output"
fi

OPTS=""
if [ -n $EASYRSA_OPTS ]; then
    OPTS=$EASYRSA_OPTS
fi

tar xzfv output/ca.tar.gz

easyrsa ${OPTS} build-client-full ${EASYRSA_CLIENT_CN} nopass

tar czfv ${EASYRSA_CLIENT_CN}.tar.gz pki/issued/${EASYRSA_CLIENT_CN}.crt pki/private/${EASYRSA_CLIENT_CN}.key pki/reqs/${EASYRSA_CLIENT_CN}.req
cp ${EASYRSA_CLIENT_CN}.tar.gz $EASYRSA_OUTPUT_DIR/
