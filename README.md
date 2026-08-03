# dotfiles

GNU Stow manages the shared configuration. The repository lives at `~/dotfiles`.

```bash
git clone git@github.com:ErwannRousseau/.dotfiles.git ~/dotfiles
cd ~/dotfiles
./bootstrap
```

`bootstrap` requires Xcode Command Line Tools. Install them once with
`xcode-select --install`; it installs Homebrew when absent, then applies the
package bundle, macOS defaults, and Stow links.

## Commands

```bash
./link  # refresh symlinks
./check # status: Homebrew, Stow, macOS defaults
./macos # reapply macOS defaults
```

On an existing Mac, use `./link --adopt` once to take its current configuration into the clone, then review the resulting Git diff.

`Brewfile` is shared. Add machine-only packages to the ignored `Brewfile.local`.

`~/.config/zsh/local.zsh` is local and ignored. Authenticate GitHub separately with `gh auth login`; no credential or `hosts.yml` belongs in this repository.

Git identity and SSH signing stay local:

```bash
cp ~/.gitconfig.local.example ~/.gitconfig.local
```

Set your name, email, and public signing-key path in `~/.gitconfig.local`.

VS Code settings, keybindings, snippets, and extension IDs are versioned. Its
history and workspace state remain local. Karabiner's `karabiner.json`
remains local because it contains per-device identifiers.
