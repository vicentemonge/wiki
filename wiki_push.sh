#!/bin/bash

set +e
set +x

git ci -am "up"
git push
curl -X POST \
     -H "Authorization: Token 11e0dd38aa17613860ff95a5b6cc9ec3a4dd61b4" \
     https://readthedocs.org/api/v3/projects/vmongewiki/versions/latest/builds/ | \
     grep -o '"triggered": *[^,}]*'
