# dotfiles

GNU Stow manages the shared configuration. The repository lives at `~/dotfiles`.

```bash
git clone https://github.com/ErwannRousseau/dotfiles.git ~/dotfiles
cd ~/dotfiles
./bootstrap
```

`bootstrap` supports Apple Silicon and 64-bit Intel Macs running macOS 14 or
newer. Run it as your normal user, never with `sudo`, from an interactive
terminal with internet access and enough disk space. It requires Xcode Command
Line Tools; install them once with `xcode-select --install`.

The script installs Homebrew when absent, checks Stow conflicts, installs the
pinned NVM and Node versions before the Brewfile, applies macOS defaults, links
the dotfiles, then runs `./check`. Homebrew auto-update and optional bundle
upgrades are disabled; required dependencies may still be updated.
The macOS account short name can differ; paths use `$HOME` and Codex machine
state is regenerated locally.

## Commands

```bash
./link                 # preflight, then refresh symlinks
./link --check         # detect conflicts without changing files
./link --adopt         # preflight, then adopt existing files
./check                # validate the complete managed installation
./macos                # reapply macOS defaults
```

Most files under `packages/` are symlinked into the home directory. Agent skill
restoration is documented in [docs/skills.md](docs/skills.md). Secrets, caches,
databases, and local application state stay outside the repository.

`./macos` also builds `~/Applications/Neovim Finder.app`, registers it with
LaunchServices, and makes supported text, configuration, and dotfiles open in
Neovim through Ghostty. It requires a one-time macOS Automation authorization
for Neovim Finder to control Ghostty.

After bootstrap, run `exec zsh -l` or open a new terminal so Homebrew, NVM, and
the user-local binary directory are loaded. Then launch Karabiner-Elements,
OrbStack, Ghostty, VS Code, Raycast, and Neovim Finder once. Complete the macOS
permission, system-extension, and login prompts each app displays. Bootstrap
installs these apps but cannot grant their user-consent permissions.

On an existing Mac, if the bootstrap preflight reports conflicts, run
`./link --adopt`, review the resulting Git diff, then rerun `./bootstrap`.

`Brewfile` is shared. Add machine-only packages to the ignored `Brewfile.local`.

`~/.config/zsh/local.zsh` is local and ignored. GitHub CLI's shared `config.yml`
is versioned; authenticate separately with `gh auth login`. The generated
`~/.config/gh/hosts.yml` remains local and is never committed.

Git identity and SSH signing stay local:

```bash
cp ~/.gitconfig.local.example ~/.gitconfig.local
```

Set your name, email, and public signing-key path in `~/.gitconfig.local`.
After restoring the SSH key, switch this clone back to SSH if desired:

```bash
git -C ~/dotfiles remote set-url origin git@github.com:ErwannRousseau/dotfiles.git
```

VS Code settings, keybindings, snippets, and extension IDs are versioned. Its
history and workspace state remain local. Karabiner's `karabiner.json` remains
local because it contains per-device identifiers.

The [Mac reset guide](docs/mac-reset.md) documents the encrypted continuity
archive for Codex, Raycast, and Karabiner.
