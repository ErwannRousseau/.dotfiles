# Calibration map

Work this design-tree frontier round by round during the interview.

## Root decisions

Settle these before their dependent branches:

1. Languages to support.
2. Writing operations: creation, rewrite, translation, format adaptation.
3. Important audiences, formats, and risk levels.
4. Automatic, explicit-only, or platform-constrained invocation.
5. Creation or recalibration of an existing skill.

## Evidence frontier

For each language and important context, determine:

- which writing operation or translation direction the evidence covers;
- which samples represent the desired voice;
- which samples feel wrong or outdated;
- whether before-and-after corrections exist;
- whether an observed pattern is intentional;
- where evidence is sparse or contradictory.

Accept any source the harness can extract. Use source content to answer factual questions. Ask the user to choose only when taste, identity, or tradeoffs are involved.

## Voice frontier

Explore every dimension that can change the generated behavior:

- relationship to the reader and pronouns;
- confidence, stance, and degree of opinion;
- spoken versus formal syntax;
- warmth, humor, imagery, and their limits;
- sentence rhythm, paragraph shape, openings, transitions, and endings;
- concrete versus abstract vocabulary;
- domain jargon, preferred untranslated terms, and banned substitutions;
- surface editing versus reconstruction of ideas and structure;
- optional compression and length constraints;
- professional, sensitive, incident, security, or bad-news calibration;
- differences between languages rather than word-for-word translation.

Register a dynamic branch when the corpus or a blind test exposes a distinctive behavior not covered here. Define its trigger, non-trigger, precedence over general rules, fallback, and observable result; test both sides.

## Recommendation rule

Recommend one answer for every question. Base it on the strongest available evidence and name the tradeoff briefly. When evidence conflicts, show the smallest excerpts needed to make the choice clear.

## Confidence rule

Record each conclusion in the calibration ledger as supported, chosen, or provisional:

- **Supported:** repeated, consistent evidence.
- **Chosen:** explicit user preference, which outranks old frequency.
- **Provisional:** sparse or ambiguous evidence explicitly accepted by the user as a hypothesis and blind-test target.

## Calibration completion

The frontier is empty when the calibration ledger covers every requested branch and has no settled prerequisite hiding an unanswered choice. Use gate `G1` in [the run ledgers](run-ledgers.md) as the authoritative completion rule.
