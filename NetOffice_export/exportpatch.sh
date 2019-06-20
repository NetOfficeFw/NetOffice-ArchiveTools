#!/bin/bash

source ./props.sh

REVISION_LOG=revisions_sync.txt

mkdir "diff"

LAST_REVISION=$(cat last_revision.txt)

echo "Exporting SVN repository"
echo "SVN URL: $SVN_URL"
echo

while read p; do
  IFS='|' read -ra INFO <<< "$p"

  REVISION=${INFO[0]}

  if [ "$REVISION" -le "$LAST_REVISION" ]; then
    echo "Skipping revision $REVISION..."
    continue
  fi

  SVN_DIR="diff"

  echo "Exporting patch for revision r$REVISION"
  svn diff --git --force -c $REVISION $SVN_URL > "$SVN_DIR/r${REVISION}_git.patch"

  LAST_REVISION=$REVISION
  echo "$REVISION" > last_revision_exported.txt
  echo "Done exporting patch for revision r$REVISION"
  echo
done < $REVISION_LOG

