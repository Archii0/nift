#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root or using sudo."
  exit 1
fi

mv /var/nift/templates .

mv /usr/bin/nift/nift.sh .

echo "Undeployed nift successfully. Pretty nifty."