#!/bin/bash

if [ $CACHE_BUNDLE -eq 1 ]; then
rm -rf bundle.tgz
    tar -czf bundle.tgz .bundle
    scp -c blowfish -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -q\
    bundle.tgz travisci_kameleon@selleo.com:/home/travis_ci_kameleon/bundle.tgz
fi

exit 3