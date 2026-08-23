---
name: superlinter
description: Run GitHub Super-Linter locally with Docker against a file or directory, automatically selecting relevant linters from file extensions and conventional filenames. Use for `/superlinter @path`, `$superlinter @path`, or any request to lint a local file or scoped folder with Super-Linter.
---

# Super-Linter

Lint one local file or one directory scope with Docker. Let Super-Linter's native file discovery select relevant linters so support stays aligned with the installed image.

## Run

1. Resolve the path supplied after `/superlinter` or `$superlinter`. Accept a regular file or directory. Treat a leading `@` as invocation syntax, not part of the path.
2. Run:

   ```bash
   bash ~/.agents/skills/superlinter/scripts/run.sh "@<path_file_or_directory>"
   ```

3. Preserve the container exit code. Summarize selected languages/linters shown by Super-Linter and report actionable findings with file locations.
4. Do not edit the target scope unless the user separately asks for fixes.

The script uses `RUN_LOCAL=true` and `USE_FIND_ALGORITHM=true`. It mounts a file at `/tmp/lint/<filename>` or a directory at `/tmp/lint`, read-only. It defaults to `ghcr.io/super-linter/super-linter:latest` and `linux/amd64`, because the official image has no ARM64 manifest. Override with `SUPERLINTER_IMAGE` or `SUPERLINTER_PLATFORM` when needed.

To reproduce a specific Super-Linter release, set `SUPERLINTER_IMAGE`:

```bash
SUPERLINTER_IMAGE=ghcr.io/super-linter/super-linter:v8.1.0 \
  bash ~/.agents/skills/superlinter/scripts/run.sh "@<path_file>"
```

Do not manually set `VALIDATE_*` variables merely to infer linters. Native discovery handles extensions and special filenames such as `Dockerfile`; set validator flags only when the user explicitly requests a particular validator.

Source: https://github.com/super-linter/super-linter/blob/main/docs/run-linter-locally.md
