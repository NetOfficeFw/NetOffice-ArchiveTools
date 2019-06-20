#!/bin/zsh

SVNURL="https://latebindingapi.svn.codeplex.com/svn"

svn log -r 0:HEAD $SVNURL --xml > history.xml
svn log -r 0:HEAD $SVNURL > history.log
