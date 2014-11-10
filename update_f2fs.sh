#!/bin/bash
git fetch f2fs

find . -not -path '*/\.*' -name '*f2fs*' | grep -v 'update_f2fs\|recovery' | while read f2fs; do rm -rf $f2fs; git checkout f2fs/dev -- $f2fs; done

rm -rf fs/f2fs
git checkout f2fs/dev -- fs/f2fs

git log --oneline f2fs/linux-3.10 | head -1 | awk '{print $1}' | while read patch; do git cherry-pick --no-commit $patch; done
git cherry-pick --no-commit f144ab5a1102146b1115be75b9f7d734eb49e977

git status
