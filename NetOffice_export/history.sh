#!/bin/zsh

source ./props.sh

LAST_REVISION=$(cat last_revision.txt)

svn log -r $LAST_REVISION:HEAD $SVN_URL --xml > history.xml
svn log -r $LAST_REVISION:HEAD $SVN_URL > history.log
