---
name: create-write-like-me
description: "Build or recalibrate a personal writing-voice skill for creation, rewriting, translation, and format adaptation."
---

# Create Write Like Me

Build a voice skill exclusively from the user's evidence, explicit choices, and blind tests.

## 1. Locate the run

Determine whether the user is creating or recalibrating a skill. Inspect the harness for discoverable skill roots, initialization and validation tools, metadata conventions, invocation controls, and packaging support. Resolve environment facts directly. Ask the user only for decisions.

For an update, work from a staged copy and leave the installed version untouched until approval. Create the task-local records defined in [the run ledgers](references/run-ledgers.md) outside the generated skill folder.

Complete this step when the operation, staging location, supported install root, invocation options, and available validators are known.

## 2. Gather evidence

Ask which languages, writing operations, audiences, contexts, and output types the skill must support. Accept every source format the harness can read or transcribe. Index the evidence and every requested branch in the calibration ledger; treat before-and-after corrections as the strongest evidence. When the user rewrites a draft, record both the changed words and the mechanism behind them: ordering, concrete verbs, paragraph shape, prominence of details, and where responsibility appears. Keep the raw corpus in working storage and retain only distilled rules and short, approved examples in the generated skill.

Complete this step when every requested operation, language direction, and important context has evidence or an explicitly accepted provisional hypothesis with a registered test target.

## 3. Grill the voice

Read [the calibration map](references/calibration-map.md) and maintain its decision tree in the calibration ledger. Work the frontier round by round. Investigate facts yourself; reserve the interview for choices only.

Complete this step when calibration gate `G1` in the run ledgers passes.

## 4. Model the voice

Distill every settled frontier decision into one canonical working voice model. Keep each rule's supported, chosen, or provisional status from the calibration ledger. Share rules across languages only when the interview validates them as shared; keep every validated difference in its language profile.

Turn corrections into compact canonical transformations. Turn a repeated self-rewrite mechanism into a context-bound rule with its trigger, rather than a universal style preference. Preserve uncertainty instead of inventing a rule. Offer outside inspirations only as optional mechanisms; include names or links in the generated skill only when the user explicitly wants them.

Complete this step when the canonical model gives every validated decision one authoritative home and labels each rule as supported, chosen, or provisional.

## 5. Generate the skill

Read [the generated-skill contract](references/generated-skill-contract.md). Build in staging with the harness-native initializer when one exists. Let the contract govern architecture, invocation, writing branches, retained evidence, and quality gates.

Designate one section or reference in the staged skill as the canonical voice profile. Complete this step when the staged files exist and that canonical location is recorded in the calibration ledger.

## 6. Validate the build

Follow the validation ledger in [the run ledgers](references/run-ledgers.md) for the current build. Complete this step when build gate `G2` passes for the exact staged digest.

## 7. Forward-test blindly

Build and execute the isolated matrix defined in [the run ledgers](references/run-ledgers.md). Present each input and output to the user. Classify and route every failure or correction through the ledger's feedback rules. When a test exposes a new voice branch, reopen steps 3 and 4 instead of patching around it. Rebuild, revalidate, and rerun every invalidated cell with new testers.

Complete this step when matrix gate `G3` passes.

## 8. Install and package

After presenting the final evidence, obtain and record explicit install authorization. Follow delivery gate `G4`: preserve a recoverable copy of any existing skill, install the validated build in the discovered harness path, and create a portable archive when supported. Verify the installed skill from a fresh session.

Complete this step when the approved skill is discoverable, installed bytes match staging, and every promised deliverable exists.
