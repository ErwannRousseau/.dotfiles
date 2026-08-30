# Agent skills

The host lock is the source of truth:
`~/.agents/.skill-lock.json`. The repository path
`packages/agents/.agents/skills-lock.json` is a symlink to that host file, so
the repository always exposes the current host lock. `./link` maintains the
compatibility link `~/.agents/skills-lock.json` back through the repository
package; that link is not the source of truth.

Skill files are restored directly into `~/.agents/skills`; they are never
generated inside the repository or managed by Stow.

`./bootstrap` reads the host lock, restores it with the current `skills` CLI in
a temporary directory, then copies the generated `.agents/skills` directory
into `~/.agents/skills`.
