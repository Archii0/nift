#!/bin/bash

usage() {
    >&2 echo "Usage: $0 <project>"
    return 0
}

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
fi

cur="$PWD"
cd $tdir
echo "Please select a template"

select x in *; do
    template="$x"
    break
done

cd $cur
cp -R ${tdir}/$template $pdir
cd $pdir

for x in *; do
    new=$(sed "s,PROJECTNAME,$pname,g" <<< "$x")

    if [ "$x" = "$new" ]; then
        sed "s,PROJECTNAME,$pname,g" < $x > temp
        mv -f temp $x
    else
        sed "s,PROJECTNAME,$pname,g" < $x > $new
        if [ -e "$new" ]; then
            rm -f $x
        fi
    fi

done