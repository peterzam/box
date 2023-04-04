#!/bin/bash

BUILDER=podman

x=("brave" "gtkcord4" "librewolf" "mullvad-browser" "obs" "qbittorrent" "telegram" "winbox" "zoom")

if [ "$1" = "all" ] ; then
    for f in * ; do
        if [ -d "$f" ] ; then
            echo ">>>>>> Building $f <<<<<<"
            ${BUILDER} build -t peterzam/x-$f -f ./$f/Containerfile .
        fi
    done

elif [ "$1" = "selected" ] ; then
    for f in ${x[@]} ; do
        echo ">>>>>> Building $f <<<<<<"
        ${BUILDER} build -t peterzam/x-$f --no-cache -f ./$f/Containerfile .
    done


elif [ "$1" = "save-all" ] ; then
    for f in * ; do
        if [ -d "$f" ] ; then
            echo ">>>>>> Saving $f <<<<<<"
            ${BUILDER} save --output $2/$f.tar $f
        fi
    done

elif [ "$1" = "import-all" ] ; then
    for f in * ; do
        echo ">>>>>> Importing $f <<<<<<"
        ${BUILDER} import $2/$f peterzam/x-$f
    done

else
    ${BUILDER} build -t peterzam/x-$1 -f ./$1/Containerfile .
fi
