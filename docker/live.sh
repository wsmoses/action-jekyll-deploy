#!/bin/bash

set -x
set -e
set -o pipefail
# ln -s /github/workspace /srv/jekyll

cp -r -T /github/workspace /srv/jekyll
cd /srv/jekyll/
chown -R jekyll .
jekyll serve --watch
