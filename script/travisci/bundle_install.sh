#!/bin/sh

scp -c blowfish -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -q\
    travisci_kameleon@selleo.com:/home/travisci_kameleon/bundle.tgz
tar -xf bundle.tgz

bundle install --path .bundle --quiet --without=development

exit 0