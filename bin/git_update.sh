#!/bin/bash

for file in *; do
   if [ -d $file ]; then
	if [ $file != 'contrib' ]; then
	      cd $file; echo "Pulling git repro in" $file; git pull; cd ..;
	fi
   fi
done