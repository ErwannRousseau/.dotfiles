# Agent skills

The repository versions only the source lock at
`packages/agents/.agents/skills-lock.json`. The host path
`~/.agents/skills-lock.json` is a symlink to that repository file, so edits made
through either path affect the same file. Skill files are restored directly into
`~/.agents/skills`; they are never generated inside the repository or managed by
Stow.

`./bootstrap` restores the lock with the current `skills` CLI. To restore it
manually, run the same command from a temporary directory containing a copy of
the lock, then copy the generated `.agents/skills` directory into
`~/.agents/skills`.

The host directory is kept as a real directory so edits made there remain local
to the host. Updating the lock and running bootstrap refreshes its contents.
