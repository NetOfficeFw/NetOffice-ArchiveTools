#!/bin/bash
shopt -s extglob
trap "echo Exiting; exit;" SIGINT SIGTERM

source ./props.sh

REVISION_LOG=revisions_sync.txt
REVISION=$1

cd $SVN_DIR

while read p; do
  IFS='|' read -ra INFO <<< "$p"

  REVISION1=${INFO[0]}
  AUTHOR=${INFO[1]}
  DATE=${INFO[2]}
  MESSAGE_FILE=log/message_r$REVISION.txt

  if [ "$REVISION" -eq "$REVISION1" ]; then
    echo "Committing new revision to Git"
    echo "    details: author=$AUTHOR date=$DATE"
    git add -A
    git commit --author="$AUTHOR" --date="$DATE" -F "../$MESSAGE_FILE"

    echo "Done exporting revision r$REVISION"
    echo

    exit
  fi
done < ../$REVISION_LOG

