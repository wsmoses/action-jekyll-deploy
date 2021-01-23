#!/bin/bash

set -x
set -e
set -o pipefail
# ln -s /github/workspace /srv/jekyll

cp -r -T /github/workspace /srv/jekyll
cd /srv/jekyll/
chown -R jekyll .
jekyll build

echo '🧪 Deploy build'

cd /srv/jekyll/_site


TEMP=/tmp/jgdb
mkdir $TEMP

git config --global user.name "${GITHUB_ACTOR}"
git config --global user.email "${GITHUB_ACTOR}@users.noreply.github.com"

git clone https://${GITHUB_ACTOR}:${INPUT_TOKEN}@github.com/${GITHUB_REPOSITORY}.git ${TEMP} -b $1 --depth 1
cd ${TEMP}
# find . -not -path "./.git*" -not -path "." -exec rm -rf {} \;
find . -depth -not -path "./.git*" -not -path "." -exec rm -rf {} \;
cp -r -T /srv/jekyll/_site/ ${TEMP}/

git add .
git add *
git commit -am "new version $(date)" --allow-empty
git push origin $1
