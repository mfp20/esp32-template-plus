#!/bin/sh

mv $1 $1.old

git submodule deinit -f -- $1
rm -rf .git/modules/$1
git rm -f $1

