#!/bin/bash
shopt -s extglob
trap "echo Exiting; exit;" SIGINT SIGTERM

source ./props.sh

REVISION_LOG=revisions_sync.txt
LAST_REVISION=$(cat last_revision.txt)

cd $SVN_DIR

while read p; do
  IFS='|' read -ra INFO <<< "$p"

  REVISION=${INFO[0]}
  AUTHOR=${INFO[1]}
  DATE=${INFO[2]}
  MESSAGE_FILE=log/message_r$REVISION.txt

  echo "svn up -r $REVISION"
  echo 'git add -A'
  echo "git commit --author=\"$AUTHOR\" --date=\"$DATE\" -F \"../$MESSAGE_FILE\""
  echo 'pause'
  echo ''

done < ../$REVISION_LOG

