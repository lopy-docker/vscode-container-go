#!/bin/bash
source /usr/local/share/nvm/nvm.sh  
npm install -g commitizen cz-conventional-changelog conventional-changelog-cli
echo '{ "path": "cz-conventional-changelog" }' > ~/.czrc