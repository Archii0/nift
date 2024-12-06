#!/bin/bash

pname=$1
pdir="./${pname}"
tdir=/var/nift/templates

if [ -z "$pname" ]; then
    usage
    exit 1
elif ! [ -d "$tdir" ]; then
    >&2 echo "Unable to find template directory: $tdir"
    exit 2
elif [ -d "$pname" ]; then
    >&2 echo "Prject directory already exists: $pdir"
    exit 3
