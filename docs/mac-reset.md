# Mac Reset Guide

This repository contains reproducible configuration only. Personal continuity
data is stored in one encrypted archive on an external SSD, never in Git.

## Before erasing

- Commit and push every important repository. This is a check, not a backup.
- Verify that iCloud Keychain, GitHub, Codex, and the password manager can be
  accessed from another device.
- Verify that the external SSD is writable and has enough free space.

Do not archive Docker, GitHub CLI authentication, NVM, Bun, caches, plugins,
logs, or worktrees. They are restored or reinstalled separately.

## Developer tools

`./bootstrap` installs official NVM `v0.40.7`, Node `v24.15.0` as the default,
Bun, pnpm, Yarn, Semble, Graft, and Agent Device. It installs missing Brewfile
entries without upgrading packages already present.

## Codex configuration and plugins

`~/.codex` is Stow-linked from `packages/agents/.codex`. It holds the
reproducible configuration. Codex may add project-trust or hook-state entries to
`config.toml`; review those generated changes before committing.

Skills remain in `~/.agents/skills`, their source of truth. Do not version or
back up credentials, `auth.json`, caches, plugins, logs, or worktrees.

After the reset, install these plugins manually through `/plugins`, then start a
new task:

- `context-mode@context-mode`
- `n8n-skills@n8n-io`
- `ponytail@ponytail`
- `figma@openai-curated`
- `build-web-apps@openai-curated`
- `expo@openai-curated`
- `codex-security@openai-curated`

Built-in OpenAI plugins and their cache regenerate automatically. Reconnect each
external service afterwards. Initialize Graft only in repositories that need it:

```bash
graft init --no-build -y
```

## Raycast and Karabiner

Raycast's `Export Settings & Data` command creates an encrypted `.rayconfig`
file. Create the destination directory, then export it before the archive and
save it as `/Volumes/<SSD_NAME>/mac-continuity/raycast-YYYY-MM-DD.rayconfig`.
Keep its passphrase in the password manager. Do not archive `~/.config/raycast`:
it contains Raycast credentials, extensions, and local state.

```bash
mkdir -p "/Volumes/<SSD_NAME>/mac-continuity"
```

Karabiner's complete configuration lives in `~/.config/karabiner`. It remains
outside Git because `karabiner.json` contains per-device identifiers, but the
encrypted continuity archive below preserves it for the reset.

Neither the Raycast export nor the Karabiner configuration is versioned; both
remain personal machine data in the encrypted archive.

## Create the `age` identity

Do this once. Store the complete private identity in iCloud Keychain and verify
that it can be recovered from another Apple device. Keep the local copy until
the restore test succeeds. The public recipient can be versioned here: run these
commands from the repository root.

```bash
mkdir -p ~/.config/age
chmod 700 ~/.config/age
age-keygen -o ~/.config/age/key.txt
age-keygen -y ~/.config/age/key.txt > age-recipients.txt
git add age-recipients.txt
```

## Back up before erasing the Mac

After exporting Raycast, quit Codex, ChatGPT, Raycast, and Karabiner-Elements.
In a Zsh terminal, flush the history and create the archive. Run this from the
repository root and replace `<SSD_NAME>` with the external SSD volume name. The
surrounding subshell is intentional: a failed preflight returns to the prompt
instead of closing the interactive terminal.

```bash
(
  set -euo pipefail
  repo_dir="$(git rev-parse --show-toplevel)"
  fc -W ~/.zsh_history
  ssd_volume="/Volumes/<SSD_NAME>"
  test -d "$ssd_volume" || {
    printf 'SSD introuvable : %s\n' "$ssd_volume" >&2
    exit 1
  }
  backup_dir="$ssd_volume/mac-continuity"
  backup_file="$backup_dir/mac-continuity-$(date +%F).tar.gz.age"
  raycast_file="$backup_dir/raycast-$(date +%F).rayconfig"
  mkdir -p "$backup_dir"
  test -s "$raycast_file" || {
    printf 'Export Raycast introuvable : %s\n' "$raycast_file" >&2
    exit 1
  }

  tar --exclude='.ssh/agent' -C "$HOME" -czf - \
    .zsh_history \
    .ssh \
    .gitconfig.local \
    .secrets \
    .codex/dictation-history \
    .codex/history.jsonl \
    .codex/sessions \
    .codex/memories \
    .codex/memories_1.sqlite \
    .codex/thread_history_1.sqlite \
    .codex/visualizations \
    .config/karabiner \
    "Library/Application Support/Raycast/script-commands" \
    | age -R "$repo_dir/age-recipients.txt" -o "$backup_file"
)
```

The archive contains Zsh history, the complete SSH configuration and keys, local
Git identity and signing settings, `~/.secrets`, and Codex automations,
dictation history, thread history, sessions, archived sessions, memories,
attachments, generated images, and visualizations. It also contains Raycast
script commands and the complete Karabiner configuration. The Raycast export
stays as a separate encrypted `.rayconfig` file next to the archive; it is not
read by `tar`. The ephemeral SSH-agent socket directory is excluded because it
contains no keys. The archive excludes Raycast credentials, Codex `auth.json`,
caches, plugins, logs, and worktrees.

## Test the backup

Do not erase the Mac before this succeeds:

```bash
(
  set -euo pipefail
  backup_dir="/Volumes/<SSD_NAME>/mac-continuity"
  backup_file="$backup_dir/mac-continuity-YYYY-MM-DD.tar.gz.age"
  raycast_file="$backup_dir/raycast-YYYY-MM-DD.rayconfig"
  test -s "$backup_file"
  test -s "$raycast_file"
  restore_dir=$(mktemp -d /tmp/mac-continuity.XXXXXX)
  age -d -i ~/.config/age/key.txt "$backup_file" | tar -xzf - -C "$restore_dir"
  test_home=$(mktemp -d /tmp/mac-continuity-home.XXXXXX)
  cp "$restore_dir/.zsh_history" "$test_home/.zsh_history"
  cp "$restore_dir/.gitconfig.local" "$test_home/.gitconfig.local"
  rsync -a "$restore_dir/.ssh/" "$test_home/.ssh/"
  rsync -a "$restore_dir/.secrets/" "$test_home/.secrets/"
  rsync -a "$restore_dir/.codex/" "$test_home/.codex/"
  test -f "$restore_dir/.config/karabiner/karabiner.json"
  test -d "$restore_dir/Library/Application Support/Raycast/script-commands"
  test -s "$test_home/.zsh_history"
  test -s "$test_home/.gitconfig.local"
  test -s "$test_home/.ssh/id_ed25519"
  test -n "$(find "$test_home/.secrets" -type f -name '*.p8' -print -quit)"
  test -d "$test_home/.codex/sessions"
  test -d "$test_home/.codex/memories"
  test -f "$test_home/.codex/thread_history_1.sqlite"
  test -f "$test_home/.codex/memories_1.sqlite"
  test "$(stat -f '%Lp' "$test_home/.ssh")" = 700
  test "$(stat -f '%Lp' "$test_home/.ssh/id_ed25519")" = 600
  test "$(stat -f '%Lp' "$test_home/.gitconfig.local")" = 600
  test "$(stat -f '%Lp' "$test_home/.secrets")" = 700
)
```

## Restore after the reset

Install the Xcode Command Line Tools, clone the public repository over HTTPS,
and run `./bootstrap` as the normal user. HTTPS is required at this stage
because the SSH key has not been restored yet:

```bash
git clone https://github.com/ErwannRousseau/dotfiles.git ~/dotfiles
cd ~/dotfiles
./bootstrap
```

Retrieve the private identity from iCloud Keychain and write it to
`~/.config/age/key.txt` with mode `600`, then restore the archive:

```bash
mkdir -p ~/.config/age
chmod 700 ~/.config/age
chmod 600 ~/.config/age/key.txt

backup_file="/Volumes/<SSD_NAME>/mac-continuity/mac-continuity-YYYY-MM-DD.tar.gz.age"
raycast_file="/Volumes/<SSD_NAME>/mac-continuity/raycast-YYYY-MM-DD.rayconfig"
test -s "$backup_file"
test -s "$raycast_file"
restore_dir=$(mktemp -d /tmp/mac-continuity.XXXXXX)
age -d -i ~/.config/age/key.txt "$backup_file" | tar -xzf - -C "$restore_dir"
cp "$restore_dir/.zsh_history" ~/.zsh_history
cp "$restore_dir/.gitconfig.local" ~/.gitconfig.local
rsync -a "$restore_dir/.ssh/" ~/.ssh/
rsync -a "$restore_dir/.secrets/" ~/.secrets/
rsync -a "$restore_dir/.codex/" ~/.codex/
mkdir -p ~/.config "$HOME/Library/Application Support/Raycast/script-commands"
rsync -a "$restore_dir/.config/karabiner/" ~/.config/karabiner/
rsync -a "$restore_dir/Library/Application Support/Raycast/script-commands/" \
  "$HOME/Library/Application Support/Raycast/script-commands/"
git -C ~/dotfiles remote set-url origin git@github.com:ErwannRousseau/dotfiles.git
```

Install Raycast, run `Import Settings & Data`, and select `"$raycast_file"`;
enter the Raycast export passphrase. Re-authenticate Raycast extensions
afterwards.

Launch Karabiner-Elements, OrbStack, Ghostty, VS Code, Raycast, and Neovim
Finder once, then complete their macOS permission, system-extension, Automation,
and login prompts.

## Reconnect services after the reset

Service authentication is intentionally not stored in Git or the continuity
archive. Recover credentials from the password manager or platform keychain,
then reconnect explicitly:

- Codex: sign in again in the app.
- GitHub CLI: run `gh auth login`, then `gh auth status`.
- Docker: run `docker login` for each registry you use; do not copy
  `~/.docker/config.json` from the old Mac.
- npm: run `npm login` or restore the token from the password manager; never
  commit `~/.npmrc`.
- Stripe: sign in again with the Stripe CLI.
- Sanity: sign in again with the Sanity CLI.
- Convex: sign in again with the Convex CLI.
- GitHub Copilot: sign in through VS Code.
- Resend: reconnect the Resend CLI; its local credential store is not archived.
- App Store Connect/`asc`: restore the private `.p8` from `~/.secrets`, then
  recreate the `asc` key/app configuration without putting the key in the repo.

Run the service-specific status command after each login before continuing work.
