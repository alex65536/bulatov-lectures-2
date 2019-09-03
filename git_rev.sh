#!/bin/bash

if ! [[ -f "git-revision.out" ]]; then
	touch git-revision.out
fi

WAS_REV="$(cat git-revision.out)"
NEW_REV="$(git show --format=%h -s 2>/dev/null || echo unknown)"

if [[ "$WAS_REV" != "$NEW_REV" ]]; then
	echo "$NEW_REV" > git-revision.out
fi
