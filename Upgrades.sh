#!/bin/sh

export DEBIAN_FRONTEND=noninteractive &&

echo "executing autoremove" &&
apt-get -fuy autoremove &&

echo "executing update" &&
apt-get update &&

echo "executing upgrade" -o Dpkg::Options::="--force-confdef" -fuy upgrade -y
