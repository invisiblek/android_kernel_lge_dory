#!/bin/bash
git fetch f2fs

find . -not -path '*/\.*' -name '*f2fs*' | grep -v 'update_f2fs\|recovery' | while read f2fs; do rm -rf $f2fs; git checkout f2fs/dev -- $f2fs; done

rm -rf fs/f2fs
git checkout f2fs/dev -- fs/f2fs

git log --oneline f2fs/linux-3.10 | head -1 | awk '{print $1}' | while read patch; do git cherry-pick --no-commit $patch; done
git cherry-pick --no-commit d9d3c407cd0ee6c0f166d624d2094c9232de568b
git cherry-pick --no-commit 86bbd59fdb8fd8835e4fd446ce11640c681860d3

git status
