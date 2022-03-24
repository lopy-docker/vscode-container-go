#!/bin/bash
source /usr/local/share/nvm/nvm.sh  
npm install -g commitizen cz-conventional-changelog
echo '{ "path": "cz-conventional-changelog" }' > ~/.czrc