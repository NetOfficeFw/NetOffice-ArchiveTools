#!/bin/bash
SVN_URL="https://latebindingapi.svn.codeplex.com/svn"

REVISION_LOG=revisions_sync.txt

mkdir "export"

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

  SVN_DIR="export/svn_r$REVISION"

  echo "Exporting revision r$REVISION"
  svn export --force -r $REVISION $SVN_URL $SVN_DIR

  LAST_REVISION=$REVISION
  echo "$REVISION" > last_revision_exported.txt
  echo "Done exporting revision r$REVISION"
  echo
done < $REVISION_LOG

