#!/bin/bash

echo "mkdir tmp dir"
tmpSource=`pwd`
tmpDir=${tmpSource}/osslsigncode
mkdir ${tmpDir} -p

echo "install osslsigncode"
cd ${tmpDir}
fetch --repo="https://github.com/mtrojnar/osslsigncode" \
  --tag=2.3 \
  --release-asset="osslsigncode-2.3.0.tar.gz" \
  .
tar -zxvf osslsigncode-2.3.0.tar.gz
cd osslsigncode-2.3.0
./configure && make && sudo make install


echo "install soloc"
solidityVersion=v0.8.15
fetch --repo="https://github.com/ethereum/solidity" --tag="${solidityVersion}" --release-asset="solc-static-linux" .
chmod +x solc-static-linux
mv solc-static-linux /usr/local/bin/solc

echo "upx bin in /usr/local/bin"
cd /usr/local/bin
upx -9 solc osslsigncode


echo "delete tmp dir"
cd ${tmpSource}
rm -rf ${tmpDir}