#!/bin/bash
git reset --hard
if [ "${1}" = "nozip" ] ; then
	git ls-files . --ignored --exclude-standard --others --directory | grep -v 'zip' | while read file; do echo $file; rm -rf $file; done
else
	git ls-files . --ignored --exclude-standard --others --directory | while read file; do echo $file; rm -rf $file; done
fi
git ls-files . --exclude-standard --others --directory | while read file; do echo $file; rm -rf $file; done
cp defconfig .config
