#!/bin/bash

# install pandoc
wget https://github.com/jgm/pandoc/releases/download/2.11.4/pandoc-2.11.4-1-amd64.deb
dpkg -i pandoc-2.11.4-1-amd64.deb

# ensure Skeleton is cloned https://github.com/dhg/Skeleton
git submodule --init --recursive
