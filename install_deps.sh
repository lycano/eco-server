#!/bin/bash
apt-get update -qq -y || exit 1
apt-get -y --allow-unauthenticated install unzip wget || exit 1

rm -rf /var/lib/apt/lists/* /tmp/*

exit 0
