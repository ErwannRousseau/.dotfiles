---
name: deepinit
description: Map a repository and structure its AGENTS.md guidance.
disable-model-invocation: true
---

# deepinit

Deeply understand the repository, then create or improve the **smallest useful
hierarchy of `AGENTS.md` files** for future coding agents.

The goal is not comprehensive documentation. Preserve only **non-obvious project
knowledge that materially changes how an agent should work**.

**Deep investigation, sparse documentation.**

## Usage

Use `/deepinit` for the default upsert path. Add a mode when the task needs a
focused path:

```text
/deepinit rebuild
/deepinit audit
/deepinit scope <path>
```

## Scope

Write only `AGENTS.md` files in mutating modes.

Apply clear, evidence-backed fixes in `audit` mode.

Report unresolved and normative choices in `audit` mode. Do not decide them
silently.

Treat source code, tests, configuration, existing docs, Git history, issues,
PRs, and connected repository context as evidence.

Keep generated and vendored material at its boundary. Add guidance only for
project-specific behavior inside that boundary.

## Modes

### Upsert — default

Audit the existing hierarchy first. Preserve useful human guidance while:

- correct strongly evidenced stale factual claims;
- remove generic, duplicated, obvious, or obsolete guidance;
- move guidance to the scope where it belongs;
- add or remove nested `AGENTS.md` files when knowledge boundaries warrant it.

### Rebuild

Read every existing `AGENTS.md` file before a rebuild.

Reconstruct the hierarchy from a fresh repository model.

Use rebuild only for an incoherent, obsolete, duplicated, or incomplete
hierarchy.

Preserve useful human intent when moving or removing `AGENTS.md` files.

Rebuild is not the routine path; default upsert is safer for incremental
maintenance.

### Audit

Audit the hierarchy and apply unambiguous, evidence-backed `AGENTS.md` fixes.
Ask before resolving a normative contradiction. Read
[the progressive-disclosure audit prompt](references/progressive-disclosure-audit.md).

### Scope

Inspect only the requested domain and its inherited parent guidance.

Record the local-versus-parent decision before writing.

Record the proposed local delta before writing.

Use scope mode for a package, app, or technical boundary such as
`scope packages/api`. Do not rebuild unrelated scopes.

## Principles

### Evidence over assumptions

Back every project-specific `AGENTS.md` claim with repository evidence.

Infer a pattern only from multiple credible signals.

Keep rationale evidence-bound.

State a proven boundary without inventing its rationale.

Use Git history and connected issue/PR context only to resolve ambiguity,
establish durable rationale, or verify staleness.

### Knowledge boundaries over filesystem boundaries

Place `AGENTS.md` where **working context changes**. Do not use directory size
as a placement criterion.

Create a local file only for materially distinct architecture, conventions,
invariants, validation rules, gotchas, anti-patterns, or technology guidance.

Create a file for a tiny critical domain when its knowledge differs. Do not
create one for a huge conventional directory.

**Complexity triggers investigation, not documentation.**

### Child is a delta from parent

Inherit parent guidance in nested files.

Write only the local delta in a child file.

### Capability-first, path-second

Name stable responsibilities, concepts, and boundaries. Do not create brittle
path catalogs.

Pair every repository-relative path with its invariant and required change.

Omit paths that only locate ordinary code, list a directory, or restate the
current tree.

### Every line earns its context cost

Before retaining a line, ask:

> Would a future coding agent plausibly behave worse without this?

Remove generic advice, no-ops, duplication, stale detail, vague rules, and
trivially discoverable facts.

### Write rules as atomic instructions

Write each guidance rule as one imperative, testable instruction.

- Give each rule one responsibility.
- Name its subject explicitly.
- State prohibited actions clearly when risk requires one.
- Omit rationale unless it changes the decision.

### Source is not guidance

Do not paraphrase nearby source, configuration, or tests in `AGENTS.md`.

Omit behavior that an agent can recover cheaply from the relevant scope.

Do not create a local `AGENTS.md` that merely copies code in prose.

Document a contract or invariant only when its durable decision, rationale,
owner, or required cross-boundary action is non-obvious and easy to break.

State the non-obvious constraint. Do not restate visible mechanics.

### Sub-agents discover; the parent decides

Run independent investigation axes as **parallel sub-agents**.

Keep each sub-agent's assumptions and local context isolated.

Partition sub-agents by repository need. Do not use a fixed agent template.

Give each sub-agent one distinct question or domain.

Give each sub-agent only the context it needs.

Scale sub-agent count and scope to the repository.

Use parallelism for **context isolation and independent evidence gathering**.
Do not use it to satisfy a fixed agent count.

Require sub-agents to return evidence and findings.

Keep reconciliation, placement, wording, and final decisions with the parent.

## Workflow

### 1. Reconnaissance

Build an initial repository map before deciding where documentation belongs.

Identify as applicable:

- project purpose and major runtime surfaces;
- packages/workspaces and architectural domains;
- entry points and dependency direction;
- data/state boundaries;
- build, test, and validation shape;
- generated, vendored, or boilerplate-heavy areas;
- existing `AGENTS.md` hierarchy;
- existing docs or skills already carrying detailed guidance.

Use the best inspection tools available in the current environment.

Keep the workflow independent of any one harness, tool family, or agent API.

**Done when:** the major knowledge boundaries are clear enough to partition
deeper investigation, and the map records project purpose, package/workspace
tooling, non-standard build/typecheck commands, runtime boundaries, existing
`AGENTS.md` files, and disclosed guidance sources.

### 2. Parallel investigation

Spawn parallel sub-agents across the independent domains or questions discovered
during reconnaissance.

Investigate applicable architecture, packages/apps, data, auth/security areas,
validation, build/deployment, and project conventions.

Each investigation should return:

- findings that would materially affect future coding work;
- supporting evidence;
- candidate invariants, conventions, validation rules, or gotchas;
- ambiguities or contradictions;
- whether local `AGENTS.md` guidance appears warranted.

**Done when:** every applicable investigation axis has returned findings,
evidence, placement input, and unresolved questions, or is explicitly marked not
applicable.

### 3. Reconcile

Aggregate findings into one repository model.

Resolve descriptive conflicts from evidence.

Pause on a normative conflict that changes behavior.

Ask the user which normative instruction to keep before writing either one.

Distinguish:

- **descriptive claims** — correct them when strong evidence shows they are
  stale;
- **normative instructions** — preserve explicit human intent unless clearly
  superseded; record the user's choice for any unresolved conflict.

Treat repeated observations as candidates.

Promote a candidate to a convention only when evidence supports intent.

Understand generated and vendored code at its boundary.

Keep deep investigation focused on project-owned behavior.

**Done when:** every finding has a status—accepted evidence, stale claim,
explicit human instruction, user-resolved conflict, or unresolved question—and
the repository model contains no silently chosen normative policy.

### 4. Coverage pass

Try to falsify the repository model.

Look for a material architectural boundary, local convention, invariant,
validation rule, or gotcha that is still uncovered.

Launch targeted sub-agent investigations when important gaps or conflicts
remain.

Stop when another meaningful coverage pass finds no material uncovered knowledge
boundary.

**Completion criterion:** every important project-specific fact that could
materially change how a future coding agent works is either covered by validated
evidence or explicitly identified as unresolved.

### 5. Distill

Keep only persistent guidance worth loading on future tasks.

Prioritize:

- non-obvious architecture and boundaries;
- where to make classes of changes;
- project-specific conventions;
- durable rationale when evidenced;
- invariants that must survive refactors;
- special validation requirements;
- dangerous local anti-patterns;
- recurring gotchas.

Treat package manifests, configuration, scripts, directory layout, and `--help`
output as sources of truth.

Document an unwritten convention, durable reason, gotcha, or expensive lookup
only when the environment cannot provide it cheaply.

Omit full trees, exhaustive file lists, generic framework advice, standard
behavior, and facts easy to recover just-in-time.

Keep these root essentials when evidenced:

- one-sentence project purpose;
- the package manager when it is not npm, including workspace usage;
- non-standard build or typecheck commands;
- instructions relevant to every task in the repository.

Put language-, package-, and domain-specific detail in nested `AGENTS.md` files
or existing reference docs.

Reach existing reference docs through a conditional pointer.

**Investigation depth does not determine documentation length.**

**Done when:** every candidate line has a retain, remove, or disclose decision,
with evidence or explicit human intent, and root content contains only the root
essentials plus repository-wide guidance.

### 6. Place

Create the hierarchy from **knowledge scope**.

Put only repository-wide guidance in root files.

Create a nested `AGENTS.md` only when local context materially differs from
its parent.

Use existing docs or skills for progressive disclosure.

Create a nested `AGENTS.md` at the domain boundary only when no suitable
reference exists.

Name the subject and trigger in every pointer, for example: “For TypeScript
changes, see `docs/TYPESCRIPT.md`.”

Keep one pointer per distinct branch.

For every significant domain considered, decide consciously:

- local `AGENTS.md` warranted; or
- parent guidance sufficient.

**Done when:** every significant domain has an explicit parent/local/disclosed
decision, every disclosed target exists, and every pointer has a clear trigger.

### 7. Write

Use these headings as optional `AGENTS.md` vocabulary.

Include a heading only when evidence supports useful scoped content.

```md
# <scope>

<one-sentence purpose>

<only evidence-backed sections relevant to this scope>
```

Start root files with purpose and repository-wide essentials.

Write only the local delta in domain files.

Use only evidence-backed headings: `WHERE TO LOOK`, `DISCLOSURE`,
`ARCHITECTURE`, `CONVENTIONS`, `INVARIANTS`, `ANTI-PATTERNS`, `VALIDATION`, and
`NOTES`.

Omit empty headings.

Write each guidance rule as a standalone bullet.

Give each bullet one subject, one responsibility, and one testable action.

State prohibited actions explicitly when risk requires one.

Keep purpose and scope descriptions readable. Do not turn them into artificial
rules.

Use this shape:

```md
- The <subject> <imperative action>.
- Do not <risky action>.
```

#### INVARIANTS

Use this heading only for multiple durable, high-consequence constraints.

Put each isolated rule in its owning heading: `ARCHITECTURE`, `CONVENTIONS`, or
`ANTI-PATTERNS`.

Omit `INVARIANTS` when it would be a template label rather than useful guidance.

#### WHERE TO LOOK

Name a capability or responsibility before a path.

Add a path only as an actionable breadcrumb for a non-obvious change.

Add a conditional pointer when detailed guidance lives elsewhere.

Use a code-formatted repository-relative path for every disclosed file, such as
`docs/TYPESCRIPT.md`. Do not use Markdown links.

Put the trigger before the path.

Place the pointer at the first scope that needs it.

#### ANTI-PATTERNS

Name each project-specific approach that is wrong, dangerous, or contrary to
the intended architecture.

Include this heading only when evidence proves a local trap, its consequence,
and its safe route.

Omit generic prohibitions, structural restatements, and ordinary hygiene.

#### NOTES

Put important project-specific gotchas or context here only when no other
heading owns them.

**Done when:** every selected file contains only accepted, scoped guidance; root
essentials are present when evidenced; conditional pointers resolve; and the
resulting hierarchy is ready for the review gates below.

## Review gates

Review the resulting hierarchy as one merged context.

Verify that:

- every line has project-specific value;
- stale, generic, obvious, and duplicated guidance is gone;
- parent/child duplication is gone;
- inferred conventions have enough evidence;
- rationale is not invented;
- explicit normative guidance is preserved or changed with user confirmation;
- each child contains a real local delta;
- no `AGENTS.md` merely paraphrases source, configuration, or tests that agents
  can inspect cheaply;
- each `ANTI-PATTERNS` entry names an evidenced local trap; absent entries are
  omitted;
- each `INVARIANTS` heading contains multiple durable, high-consequence
  constraints; isolated rules use their owning heading instead;
- each `ARCHITECTURE` path is an actionable breadcrumb for an invariant, not a
  structural description;
- root contains only repository-wide guidance;
- no file exists merely because a directory is large;
- every disclosed target exists and every pointer names its trigger;
- root essentials are present when evidenced;
- the diff contains only `AGENTS.md` paths.

Prefer the **shortest `AGENTS.md` that preserves all high-value guidance for its
scope**. There are no target line counts.

**Done when:** the merged hierarchy passes every gate above and no unresolved
normative conflict remains unconfirmed by the user.

## Final report

Finish with a compact recap:

```text
deepinit complete

Mode
- default | rebuild | audit | scope

Investigated
- major boundaries/domains examined
- targeted follow-up investigations, if any

AGENTS.md
- <path> — created | updated | removed

Deliberately not created
- <scope> — parent guidance is sufficient

Cleaned up
- stale, duplicated, generic, or misplaced guidance corrected/removed

Unresolved
- genuine ambiguities that could not be established from evidence
```

Report coverage and documentation decisions. Use file, line, and agent counts
only as operational details, never as quality metrics.
