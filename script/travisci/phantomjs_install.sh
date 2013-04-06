#!/bin/bash

if [ $CAPYBARA_DEFAULT_DRIVER == "poltergeist" ]; then
wget https://phantomjs.googlecode.com/files/phantomjs-1.9.0-linux-x86_64.tar.bz2
tar -xf phantomjs-1.9.0-linux-x86_64.tar.bz2
sudo rm -rf /usr/local/phantomjs
sudo mv phantomjs-1.9.0-linux-x86_64 /usr/local/phantomjs

fi

exit 0
