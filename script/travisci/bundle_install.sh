#!/bin/sh

scp -v -c blowfish -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -q \
    travisci_kameleon@selleo.com:/home/travisci_kameleon/bundle.tgz ./
if [ -f "bundle.tgz" ]; then
    tar -xf bundle.tgz
fi

bundle install --path .bundle --quiet --without=development

exit 0