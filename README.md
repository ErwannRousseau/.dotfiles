# dotfiles

GNU Stow manages the shared configuration. The repository lives at `~/dotfiles`.

```bash
git clone git@github.com:ErwannRousseau/.dotfiles.git ~/dotfiles
cd ~/dotfiles
./bootstrap
```

`bootstrap` requires Xcode Command Line Tools. Install them once with
`xcode-select --install`; it installs Homebrew when absent, then applies the
package bundle, macOS defaults, Finder-to-Neovim associations, and Stow links.

## Commands

```bash
./link  # refresh symlinks
./check # status: Homebrew, Stow, macOS defaults
./macos # reapply macOS defaults
```

Most files under `packages/` are symlinked into the home directory. The skill
directory `packages/agents/.agents/skills` is linked to `~/.agents/skills` as a
directory, so Codex sees regular skill files and both paths stay in sync.
Secrets, caches, databases, and local application state stay outside the
repository.

`./macos` also builds `~/Applications/Neovim Finder.app`, registers it with
LaunchServices, and makes supported text, configuration, and dotfiles open in
Neovim through Ghostty. It requires a one-time macOS Automation authorization
for Neovim Finder to control Ghostty.

On an existing Mac, use `./link --adopt` once to take its current configuration into the clone, then review the resulting Git diff.

`Brewfile` is shared. Add machine-only packages to the ignored `Brewfile.local`.

`~/.config/zsh/local.zsh` is local and ignored. GitHub CLI's shared `config.yml`
is versioned; authenticate separately with `gh auth login`. The generated
`~/.config/gh/hosts.yml` remains local and is never committed.

Git identity and SSH signing stay local:

```bash
cp ~/.gitconfig.local.example ~/.gitconfig.local
```

Set your name, email, and public signing-key path in `~/.gitconfig.local`.

VS Code settings, keybindings, snippets, and extension IDs are versioned. Its
history and workspace state remain local. Karabiner's `karabiner.json`
remains local because it contains per-device identifiers.

The [Mac reset guide](docs/mac-reset.md) documents the Codex and `age`
continuity process.
