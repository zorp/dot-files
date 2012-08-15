#!/bin/bash

for file in *; do
  if [ -d $file ]; then
	  if [ $file != 'contrib' ]; then
	    cd $file
	    if ! git ls-files >& /dev/null; then
        echo "NOT GIT - " $file "not in git"
      else
	      echo "Pulling git repro in" $file; git pull;
	    fi
	    cd ..;
	  fi
  fi
done