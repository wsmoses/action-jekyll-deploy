#!/bin/bash

set -x
set -e
set -o pipefail
# ln -s /github/workspace /srv/jekyll

cd /github/workspace

jekyll build

echo '🧪 Deploy build'

cd /srv/jekyll/_site
git init .
git add .
git config user.name "${GITHUB_ACTOR}"
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"
git commit -am "🧪 Deploy with ${GITHUB_WORKFLOW} $(date)" --allow-empty
git push --all -f https://${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git $1
