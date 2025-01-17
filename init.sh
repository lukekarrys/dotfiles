#!/bin/sh

sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /tmp/bin init --ssh --apply --force --source "$HOME/.local/data/chezmoi" lukekarrys
