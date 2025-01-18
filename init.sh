#!/bin/sh

sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /tmp/bin init --use-builtin-git true --apply --force --source "$HOME/.local/data/chezmoi" lukekarrys
