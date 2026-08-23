# Run ledgers

Create one task-local run directory outside the generated skill and archive. Use stable names: `run-manifest.md`, `calibration-ledger.md`, `validation-ledger.md`, `events.md`, and `tests/<cell_id>/`. Never overwrite history; append events and mark superseded rows. These records are the single source for gates `G1`–`G4`.

## Run manifest

Record `schema_version`, `run_id`, operation, source-skill path and digest when recalibrating, staging path, chosen invocation mode, harness facts, expected artifacts, and the current model revision and build ID. Give every corpus item an evidence ID plus its type, language, location, and content hash. Checkpoint the manifest after each gate.

## Calibration ledger

Record a build-neutral branch inventory with these fields:

| Field | Meaning |
|---|---|
| `branch_id` | Stable identifier |
| `model_revision` | Revision that owns the decision |
| `source_language` | Source language when relevant |
| `target_language` | Output language; never implies the reverse direction |
| `direction_id` | Stable source→target identifier for translation |
| `operation` | Creation, rewrite, translation, or adaptation |
| `context` | Audience, format, and risk level |
| `dynamic_branch` | Optional trigger, non-trigger, precedence, fallback, and expected behavior |
| `evidence` | Evidence IDs or minimal excerpts with hashes |
| `status` | Supported, chosen, or provisional |
| `decision` | Executable voice behavior |
| `prerequisites` | Decisions that must settle first |
| `test_cells` | Matrix cells that prove the branch |
| `profile_location` | Canonical generated-skill section or file |

For every provisional entry, record the user's explicit acceptance, the hypothesis, and its required blind-test cells. `Provisional` is an allowed, visible rule status, not a TODO or unresolved placeholder. A later user decision must transition it to supported, chosen, rejected, or a new provisional revision and invalidate affected cells.

Give every translation direction an executable rule location and direction-specific cells. A shared target-language rule is valid only when the user confirms it and each covered direction passes independently. Never infer reverse-direction coverage.

The decision tree is complete when every requested and dynamically discovered branch has a row, every prerequisite is settled, every contradiction has a decision, every provisional has a test target, and no available frontier remains. Dynamic rows require positive and negative cells. If a forward test exposes a new branch, add it and reopen calibration. Record the user's separate confirmation of the complete summary as a `model_confirmed` event.

## Events

Append events with an immutable `event_id`, timestamp, actor, `actor_role`, event type, model revision, build ID or digest when relevant, affected rows or cells, decision, typed payload, and evidence locations. Store each confirmed model summary as `model-summary-<revision>.md`. A `model_confirmed` payload requires its summary path and hash; `cell_approved` requires cell ID, build digest, output path, and output hash; `install_authorized` requires the approved build digest. Required event types are `model_confirmed`, `feedback_received`, `cells_invalidated`, `cell_approved`, `provisional_transition`, `install_authorized`, `installed`, and `rolled_back`. User approvals require `actor_role=user`; never infer them from agent-authored text.

## Validation ledger

Identify each generated build with a content digest and link it to its model revision, staging path, and manifest checkpoint. Record:

1. Native validator command, coverage, result, and evidence when available.
2. Manual audit results for required metadata, resolvable context pointers, supported platform files, unfinished markers, duplicated rules, and every calibration-ledger decision's executable location.
3. One test-matrix row for every required cell:

| Field | Meaning |
|---|---|
| `cell_id` | Stable identifier |
| `build_id` | Exact build tested |
| `branches` | Calibration branch IDs covered |
| `dimensions` | Operation, direction, audience, format, risk, dynamic branch, and invocation mode |
| `tester` | Fresh session or agent identifier |
| `artifacts` | Exact input, output, prompt, launch configuration, and their hashes |
| `isolation` | Pass/fail plus proof that inheritance was disabled and only staged skill + raw input were exposed |
| `facts` | Pass or fail with evidence |
| `language` | Pass or fail with evidence |
| `voice` | Pass or fail with evidence |
| `result` | Pass only when isolation, facts, language, and voice all pass |
| `approved` | Immutable event ID of the matching user-authored `cell_approved` event |
| `approver` | User identity or conversation reference |
| `approved_at` | Timestamp |

Enumerate the matrix on normalized axes. Cover every requested operation, language or direction, audience, format, risk level, and invocation mode in each combination where behavior can differ. Give each dynamic branch a trigger and non-trigger or boundary cell; add interaction cells when branch precedence could change the result. Smoke-test the staged-copy boundary during recalibration.

Accept isolation only when the tester starts with inherited conversation disabled, receives only the staged skill and raw request, and cannot see interview notes, expected answers, or earlier output. Save the exact launch configuration, staged digest, tester/session ID, input, prompt, output, and contamination check in the cell folder. Missing proof is a failed cell. Stop testing when the harness cannot provide that boundary.

## Revision and invalidation

Classify every failure or correction and append its routing event:

- voice decision or newly discovered branch: new model revision, calibration, and summary confirmation;
- facts or preserved constraints: fix the applicable invariant or implementation and invalidate every exposed sibling case;
- language or translation: create a new model revision, invalidate `G1` and affected `G3` cells, revise the relevant rule, and obtain a new confirmation of the complete summary;
- implementation only: keep the model revision and create a new build;
- isolation, tester, or harness: discard the result and rerun with valid proof; do not change the voice model without voice evidence.

Every content correction creates a new build. Validators and the manual audit rerun on that build.

Invalidate test cells by impact:

- shared-profile change: every cell;
- language change: every cell using that language or direction;
- operation change: every cell using that operation;
- context or dynamic-branch change: every mapped cell;
- unclear impact: every cell.

Preserve superseded rows and record invalidations in `events.md`. Results from an older build never satisfy the current build.

## Gates

- `G1 model`: branch inventory complete; evidence hashes resolve; provisional states are accepted; a user-authored `model_confirmed` event binds the exact summary hash to the current model revision.
- `G2 build`: staged digest links to the current model revision; native validators pass, or `validator_status=unavailable` records the reason and equivalent manual checks; the manual audit records every contract rule ID and passes.
- `G3 matrix`: every required current-build cell has complete isolation artifacts and all dimensions pass. Each row references a user-authored `cell_approved` event bound to that cell ID, build digest, and output hash, with approver and timestamp. No invalidated or failed cell remains.
- `G4 delivery`: a post-`G3` user-authored `install_authorized` event binds the exact approved build digest; any installed version has a timestamped backup and digest; replacement uses an atomic swap when the filesystem supports it; installed digest equals the approved build; archive digest and contents are recorded; a fresh-session discovery and invocation smoke test passes. On mismatch, restore the backup and record `rolled_back`.
