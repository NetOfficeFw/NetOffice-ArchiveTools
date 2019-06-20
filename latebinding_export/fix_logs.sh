#!/bin/bash
trap "echo Exiting; exit;" SIGINT SIGTERM

REVISION_LOG=revisions.txt

while read p; do
  IFS='|' read -ra INFO <<< "$p"

  REVISION=${INFO[0]}

  echo -e "\n\nImported from https://latebindingapi.codeplex.com/SourceControl/changeset/$REVISION" >> log/message_r$REVISION.txt

done < $REVISION_LOG
