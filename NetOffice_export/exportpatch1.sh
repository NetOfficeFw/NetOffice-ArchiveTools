#!/bin/bash

source ./props.sh

REVISION=$1

echo "Exporting patch for revision r$REVISION"

svn diff --force -c $REVISION $SVN_URL > "diff/r${REVISION}_new.patch"

echo "Done exporting patch for revision r$REVISION"
