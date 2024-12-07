#!/bin/bash

# Script to move running script and template directory to specific locations on linux file system

if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root or using sudo."
  exit 1
fi

chmod +x nift.sh

mkdir -p /var/nift

mv templates /var/nift

mkdir -p /usr/bin/nift

mv nift.sh /usr/bin/nift

echo "Deployed nift successfully. Pretty nifty."