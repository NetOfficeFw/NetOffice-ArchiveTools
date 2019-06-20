#!/bin/bash

source ./props.sh

transform -s:history.xml -xsl:log.xslt -o:revisions_sync.txt
transform -s:history.xml -xsl:log_messages.xslt -o:messages_sync.txt

REVISION_LOG=revisions_sync.txt

while read p; do
  IFS='|' read -ra INFO <<< "$p"

  REVISION=${INFO[0]}

  echo -e "\n\nImported from NetOffice $REVISION\n$SVN_URL_BASE/SourceControl/changeset/$REVISION" >> log/message_r$REVISION.txt

done < $REVISION_LOG
