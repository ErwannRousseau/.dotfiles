# Progressive-disclosure audit

Use this reference when `deepinit audit` is requested. It is a review prompt
that applies unambiguous `AGENTS.md` fixes directly.

```text
I want you to refactor my AGENTS.md file to follow progressive disclosure
principles.

Follow these steps:

1. **Find contradictions**: Identify any instructions that conflict with each
   other. For each contradiction, ask me which version I want to keep.

2. **Identify the essentials**: Extract only what belongs in the root AGENTS.md:

   - One-sentence project description
   - Package manager (if not npm)
   - Non-standard build/typecheck commands
   - Anything truly relevant to every single task

3. **Group the rest**: Organize remaining instructions into logical categories
   (e.g., TypeScript conventions, testing patterns, API design, Git workflow).
   For each group, create a separate markdown file.

4. **Create the file structure**: Output:

   - A minimal root AGENTS.md with code-formatted paths to the separate files
   - Each separate file with its relevant instructions
   - A suggested docs/ folder structure

5. **Flag for deletion**: Identify any instructions that are:

   - Redundant (the agent already knows this)
   - Too vague to be actionable
   - Overly obvious (like "write clean code")
```

During the audit, preserve repository evidence and distinguish descriptive
claims from normative instructions. Ask for a decision before changing a
normative contradiction. Apply unambiguous fixes directly and report proposed
file placement separately from edits.
