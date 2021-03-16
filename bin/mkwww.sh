#!/bin/bash

WWWSRC=$(pwd)
BIN="$WWWSRC"/bin
BUILD="$WWWSRC"/_build

export PYTHONPATH=.

mkdir -p "$BUILD"

# copy static files into root directory
cp -R "$WWWSRC"/static/* "$BUILD"/

function build_page () {
    # $1 -> dest dir, relative to $BUILD (webroot), without leading /
    # $2 -> source md, full path
    # $3 -> page title (quoted for shell to give as single argument)
    mkdir -p "$BUILD"/"$1"
    fnbody=$(mktemp)
    pandoc --from markdown_strict+table_captions+header_attributes+implicit_header_references+simple_tables+fenced_code_blocks+pipe_tables+fenced_divs+link_attributes -w html -o "$fnbody" "$2"
    "$BIN"/strformat.py body="$fnbody" title="$3" head="" < "$WWWSRC"/template.html > "$BUILD"/"$1"/index.html
    rm "$fnbody"
}

function build_pages () {
    # if you have a directory filled with pages
    # and you want to build them with the tree intact
    # e.g. for a blog
    # $1 -> name of the directory of pages you are building

    SECTION="$WWWSRC"/"$1"

    mkdir -p "$BUILD"/"$1"

    # build index
    build_page "$1" "$BUILD"/"$1"/index.md "Bluebird Terminal Services"

    # build individual pages
    for postpath in $(find "$SECTION" -name '*.md'); do
        post=${postpath##$SECTION}
        postname=${post%.md}
        build_page "$1"/"$postname" "$postpath" "$postname"
    done
}

build_page . "$WWWSRC"/index.md "Bluebird Terminal Services"

# redirects
cp "$WWWSRC"/redirects.tsv "$BUILD"/_redirects
