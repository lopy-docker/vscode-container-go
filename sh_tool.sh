#!/bin/bash


echo "install osslsigncode"
tmpSource=`pwd`
tmpDir=${tmpSource}/osslsigncode
mkdir ${tmpDir} -p
cd ${tmpDir}
fetch --repo="https://github.com/mtrojnar/osslsigncode" \
  --tag=2.3 \
  --release-asset="osslsigncode-2.3.0.tar.gz" \
  .
tar -zxvf osslsigncode-2.3.0.tar.gz
cd osslsigncode-2.3.0
./configure && make && sudo make install
cd ${tmpSource}
rm -rf ${tmpDir}