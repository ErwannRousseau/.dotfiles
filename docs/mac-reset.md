# Mac Reset Guide

This repository contains reproducible configuration only. Personal continuity
data is stored in one encrypted archive on an external SSD, never in Git.

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

Quit Codex and ChatGPT. In a Zsh terminal, flush the history and create the
archive. Replace `/Volumes/SSD` with the external SSD volume name.

```bash
fc -W ~/.zsh_history
backup_dir="/Volumes/SSD/codex-continuity"
backup_file="$backup_dir/codex-continuity-$(date +%F).tar.gz.age"
mkdir -p "$backup_dir"

tar -C "$HOME" -czf - \
  .zsh_history \
  .ssh \
  .secrets \
  .codex/automations \
  .codex/dictation-history \
  .codex/history.jsonl \
  .codex/sessions \
  .codex/archived_sessions \
  .codex/memories \
  .codex/memories_1.sqlite \
  .codex/thread_history_1.sqlite \
  .codex/attachments \
  .codex/generated_images \
  .codex/visualizations \
  | age -R age-recipients.txt -o "$backup_file"
```

The archive contains Zsh history, the complete SSH configuration and keys,
`~/.secrets`, and Codex automations, dictation history, thread history,
sessions, archived sessions, memories, attachments, generated images, and
visualizations. It excludes Codex `auth.json`, caches, plugins, logs, and
worktrees.

## Test the backup

Do not erase the Mac before this succeeds:

```bash
restore_dir=$(mktemp -d /tmp/codex-continuity.XXXXXX)
age -d -i ~/.config/age/key.txt "$backup_file" | tar -xzf - -C "$restore_dir"
test -s "$restore_dir/.zsh_history"
test -d "$restore_dir/.secrets"
test -d "$restore_dir/.codex/sessions"
test -d "$restore_dir/.codex/memories"
test -f "$restore_dir/.codex/thread_history_1.sqlite"
test -f "$restore_dir/.codex/memories_1.sqlite"
```

## Restore after the reset

Install the Xcode Command Line Tools, clone this repository, and run
`./bootstrap`. Retrieve the private identity from iCloud Keychain and write it
to `~/.config/age/key.txt` with mode `600`, then restore the archive:

```bash
mkdir -p ~/.config/age
chmod 700 ~/.config/age
chmod 600 ~/.config/age/key.txt

backup_file="/Volumes/SSD/codex-continuity/codex-continuity-YYYY-MM-DD.tar.gz.age"
restore_dir=$(mktemp -d /tmp/codex-continuity.XXXXXX)
age -d -i ~/.config/age/key.txt "$backup_file" | tar -xzf - -C "$restore_dir"
cp "$restore_dir/.zsh_history" ~/.zsh_history
rsync -a "$restore_dir/.ssh/" ~/.ssh/
rsync -a "$restore_dir/.secrets/" ~/.secrets/
rsync -a "$restore_dir/.codex/" ~/.codex/
```

Finally, log in to Codex, GitHub, and the required services again.
