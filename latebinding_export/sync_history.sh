#!/bin/zsh

SVNURL="https://latebindingapi.svn.codeplex.com/svn"
LAST_REVISION=$(cat last_revision.txt)
LAST_REVISION=$(($LAST_REVISION+1))

echo "Loading history for revisions $LAST_REVISION : HEAD"

svn log -r $LAST_REVISION:HEAD $SVNURL --xml > history_sync.xml
svn log -r $LAST_REVISION:HEAD $SVNURL > history_sync.log
