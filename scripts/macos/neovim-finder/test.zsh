#!/usr/bin/env zsh
set -euo pipefail

root="${0:A:h}"

for file in Neovim\ Finder.applescript Info.plist set-neovim-defaults.swift install.zsh; do
	[[ -f "$root/$file" ]] || { print -u2 "missing $file"; exit 1; }
done

rg -F 'new tab with configuration' "$root/Neovim Finder.applescript" >/dev/null
rg -F 'initial input' "$root/Neovim Finder.applescript" >/dev/null
rg -F 'command -v nvim' "$root/Neovim Finder.applescript" >/dev/null
rg -F 'NVM_DIR' "$root/Neovim Finder.applescript" >/dev/null
rg -F '/opt/homebrew/bin/nvim' "$root/Neovim Finder.applescript" && { print -u2 'hardcoded Homebrew path remains'; exit 1; }
rg -F '/usr/bin/env' "$root/Neovim Finder.applescript" && { print -u2 'direct execution wrapper remains'; exit 1; }
plutil -lint "$root/Info.plist" >/dev/null
"$root/install.zsh" --check

print 'Neovim Finder installer: OK'
