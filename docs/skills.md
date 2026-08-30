# Agent skills

The tracked repository lock is
`packages/agents/.agents/skills-lock.json`. Both host paths,
`~/.agents/.skill-lock.json` and `~/.agents/skills-lock.json`, are symlinks to
that file. Edit either host path; Git then shows the repository diff directly.
`./link` creates and verifies both links.

Skill files are restored directly into `~/.agents/skills`; they are never
generated inside the repository or managed by Stow.

`./bootstrap` copies the tracked lock to a temporary directory, restores it
with `skills` CLI `1.5.23`, then copies the generated `.agents/skills`
directory into `~/.agents/skills`.
