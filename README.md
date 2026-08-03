# dotfiles

GNU Stow manages the shared configuration. The repository lives at `~/dotfiles`.
Install [Homebrew](https://brew.sh/) first.

```bash
git clone git@github.com:ErwannRousseau/.dotfiles.git ~/dotfiles
cd ~/dotfiles
./bootstrap
```

## Commands

```bash
./link  # refresh symlinks
./check # verify Brewfile and Stow deployment
```

On an existing Mac, use `./link --adopt` once to take its current configuration into the clone, then review the resulting Git diff.

`Brewfile` is shared. Add machine-only packages to the ignored `Brewfile.local`.

`~/.config/zsh/local.zsh` is local and ignored. Authenticate GitHub separately with `gh auth login`; no credential or `hosts.yml` belongs in this repository.

Karabiner's `karabiner.json` remains local because it contains per-device identifiers.
