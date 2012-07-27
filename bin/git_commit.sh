#!/bin/bash

# nice in_array function taken from here: http://mykospark.net/tag/in_array/
function in_array() {
  local x
  ENTRY=$1
  shift 1
  ARRAY=( "$@" )
  [ -z "${ARRAY}" ] && return 1
  [ -z "${ENTRY}" ] && return 1
  for x in ${ARRAY[@]}; do
    [ "${x}" == "${ENTRY}" ] && return 0
  done
  return 1
}

# Make sure a commit message is provided, we would not like to commit anything to git without this.
if [ -z "$1" ]; then
  echo "You must provide a git commit message, like this: git_commit.sh 'my git commit message'";
else
  # Prepare array of excluded directories passed as arguments
  i=0; exclude=();
  for arg in "$@"; do
    exclude[$i]="$arg";
    ((++i))
  done
  
  # Remove first array value as that will be the git commit message
  gitcommit=${exclude[0]}
  unset exclude[0];
  
  # loop all elements in your current location
  for file in *; do
    if [ -d $file ]; then
      # skip anything in a contrib folder (Drupal lingo)
      if [ $file != 'contrib' ]; then
        # check if the folder is a git repro
        cd $file;
        if ! git ls-files >& /dev/null; then
          echo "NOT GIT - " $file "not in git"
        else
          in_array "${file}" "${exclude[@]}"
          RET=$?
          if [ "${RET}" -eq 0 ]; then
            echo "EXCLUDED - Doing nothing with" $file;
          else
            echo "COMMIT & PUSH - Commit git repro with message '"$gitcommit"' in" $file;
            #git commit -am "$gitcommit";
            #git pull;
            #git push;
          fi
        fi
        cd ..;
      fi
    fi
  done
fi