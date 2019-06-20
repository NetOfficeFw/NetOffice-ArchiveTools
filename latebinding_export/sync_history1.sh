#!/bin/bash

transform -s:history_sync.xml -xsl:log.xslt -o:revisions_sync.txt
transform -s:history_sync.xml -xsl:log_messages.xslt -o:messages_sync.txt

REVISION_LOG=revisions_sync.txt

while read p; do
  IFS='|' read -ra INFO <<< "$p"

  REVISION=${INFO[0]}

  echo -e "\n\nImported from https://latebindingapi.codeplex.com/SourceControl/changeset/$REVISION" >> log/message_r$REVISION.txt

done < $REVISION_LOG
