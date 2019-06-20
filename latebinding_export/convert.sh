#!/bin/bash
shopt -s extglob
trap "echo Exiting; exit;" SIGINT SIGTERM

SVN_URL="https://latebindingapi.svn.codeplex.com/svn"

REVISION_LOG=revisions_sync.txt
SVN_DIR=LateBindingGit

LAST_REVISION=$(cat last_revision.txt)

mkdir $SVN_DIR
cd $SVN_DIR

echo "Converting SVN repository to Git"
echo "SVN URL: $SVN_URL"
echo

while read p; do
  IFS='|' read -ra INFO <<< "$p"

  REVISION=${INFO[0]}
  AUTHOR=${INFO[1]}
  DATE=${INFO[2]}
  MESSAGE_FILE=log/message_r$REVISION.txt

  if [ "$REVISION" -le "$LAST_REVISION" ]; then
    echo "Skipping revision $REVISION..."
    continue
  fi

  if [ ! -d ".git" ]; then

    echo "Init Git repository."
    git init
    cp ../git_tmpl/.gitignore .gitignore
    cp ../git_tmpl/.gitattributes .gitattributes
    git add .gitignore
    git add .gitattributes
    git commit -m "Initial commit"

    echo "Repository init with revision r$REVISION"
    svn checkout -r $REVISION $SVN_URL .
  else

    if [ -d ../export/svn_r$REVISION ]; then
      echo "Using cached revision r$REVISION..."

      echo "  Deleting existing files..."
      rm -rf !(.*)
      echo "  Files deleted."

      rsync -avh --progress ../export/svn_r$REVISION/ .
    else
      echo "Revision r$REVISION not found in cache folder."

      # svn update -r $REVISION

      exit
    fi

    # echo "Exporting revision r$REVISION"
    # svn up -r $REVISION
  fi

  echo "Committing new revision to Git"
  echo "    details: author=$AUTHOR date=$DATE"
  git add -A
  GIT_TRACE=1 git commit --author="$AUTHOR" --date="$DATE" -F "../$MESSAGE_FILE"

  # cd ..

  LAST_REVISION=$REVISION
  echo "$REVISION" > ../last_revision.txt
  echo "Done exporting revision r$REVISION"
  echo
done < ../$REVISION_LOG

