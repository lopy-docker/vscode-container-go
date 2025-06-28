#!/bin/bash
source /usr/local/share/nvm/nvm.sh  
npm install -g commitizen cz-conventional-changelog conventional-changelog-cli standard-version
echo '{ "path": "cz-conventional-changelog" }' > ~/.czrc

# wrangler
npm install -g wrangler
npm install -g @google/gemini-cli