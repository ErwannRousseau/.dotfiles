---
name: php
description: Use for PHP language/runtime, security, Composer, testing, or performance work, including framework code when no more-specific framework skill applies. Identify the project's PHP floor first and let framework conventions govern framework-owned boundaries.
---

# PHP

Use this runbook for PHP-level concerns. If a framework-specific skill or
project guide exists, consult it first and keep its conventions primary. Apply
the generic rules below only where the framework does not own the behavior.

## Runbook

Follow these steps in order.

### 0. Choose the branch

- For framework-owned HTTP, routing, validation, ORM, sessions, CSRF, serialization, and exception rendering, use the framework APIs and configuration. Verify their behavior instead of replacing them with framework-agnostic examples.
- For plain PHP, framework-independent libraries, or a missing framework-specific guide, apply the relevant generic sections below.
- Apply PHP language/runtime, dependency, security invariant, and verification rules whenever they are relevant, regardless of framework.

Completion criterion: the task is classified as framework-owned, generic PHP, or both, and the framework's source of truth is known.

### 1. Establish the runtime floor

- Inspect `composer.json`, `composer.lock`, `.php-version`, Dockerfiles, CI, and
 the production runtime.
- Record the lowest supported PHP version, required extensions, framework, entry points, and existing commands for tests, linting, formatting, and static analysis.
- Treat the lowest declared PHP version as the syntax and standard-library floor. If project files disagree, surface the conflict before choosing newer syntax.

Completion criterion: the target runtime, framework conventions, and verification commands are known or explicitly stated as assumptions.

Before using a feature newer than that floor, consult [the PHP version matrix](references/php-version-matrix.md).

### 2. Trace before editing

- Read the target file, its tests, configuration, and the callers or consumers affected by the change.
- Follow the real data flow from the input boundary to output and side effects.
- Reuse existing project helpers and conventions. Add an abstraction only at a real boundary or when multiple implementations need it.

Completion criterion: every changed path and its observable failure cases are identified.

### 3. Implement with explicit types

- Use `declare(strict_types=1);` in new files and deliberate migrations; do not add it across an existing codebase blindly.
- Type parameters, properties, and return values. Keep `mixed`, untyped arrays, and dynamic shapes at integration boundaries, then normalize them into typed objects or documented arrays.
- Prefer enums for closed sets, value objects for domain invariants, and `final` or `readonly` when immutability is intentional.
- Use dependency injection for I/O and time; avoid hard-coded mail, filesystem, or network clients inside domain logic.
- Use named arguments only with APIs whose parameter names are part of a stable contract.
- Avoid dynamic properties. Use `never` only for code paths that always throw or terminate.

Completion criterion: modified public boundaries have clear input and output contracts, and no feature exceeds the runtime floor.

### 4. Keep boundaries secure

Apply these rules directly to raw boundaries. When a framework owns a boundary, use its validated request, escaping, ORM, session, or CSRF mechanisms and audit their configuration instead of bypassing them.

- Validate and normalize untrusted input at the boundary. Validation is not output escaping.
- Escape for the output context: HTML, URL, and JavaScript each require different handling. For HTML text or attributes, use `htmlspecialchars($value, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8')`.
- Hash passwords with `password_hash()` and verify with `password_verify()`. Rehash after `password_needs_rehash()` succeeds.
- Generate tokens with `random_bytes()` or `random_int()`, and compare secrets with `hash_equals()`.
- Protect cookie-authenticated state changes with CSRF defenses. Set session cookies `Secure`, `HttpOnly`, and an appropriate `SameSite` policy.
- Keep secrets, passwords, tokens, raw request bodies, and sensitive personal data out of logs and exception responses.
- Prefer explicit parsers or JSON for untrusted serialized data. Treat `unserialize()`, `eval()`, shell execution, file inclusion, and user-controlled paths as high-risk boundaries requiring a concrete justification and validation.

Completion criterion: each external input, rendered response, credential, and side effect has an identified validation or containment rule.

### 5. Handle errors at the right layer

- Throw exceptions for failed operations. Define custom exceptions under the application namespace, usually extending the closest built-in or framework exception. Do not declare a class with the same global name as a built-in such as `DomainException` or `InvalidArgumentException`.
- Namespaced custom exceptions may extend built-ins:

```php
<?php
declare(strict_types=1);

namespace App\Exception;

final class ValidationException extends \InvalidArgumentException {}
final class RuleViolationException extends \DomainException {}
```

- Catch an exception only to recover, translate it to the current boundary, add useful context, or perform cleanup. Preserve the previous exception when translating.
- At a raw process or HTTP boundary, catch `Throwable` to log safe context and return a generic response. In a framework, use its exception handler or middleware instead of adding a second global handler.
- Never swallow an exception or return success after a failed side effect.
- Use `finally` for resource cleanup.

Completion criterion: every failure is either handled at its owning boundary, propagated with context, or deliberately reported as an unresolved risk.

### 6. Use safe I/O defaults

- Validate user-controlled paths against an allowed root; do not let input select arbitrary files or commands.
- Check return values from filesystem and network operations, and surface failures with useful context.
- Use `finally` to close resources and clean up temporary state.
- Choose the clearest iteration; `array_map()` is not automatically faster than a loop.
- Stream large files with a generator and always close resources:

```php
function readLines(string $path): \Generator
{
    $handle = fopen($path, 'rb');
    if ($handle === false) {
        throw new \RuntimeException("Cannot open {$path}");
    }

    try {
        while (($line = fgets($handle)) !== false) {
            yield rtrim($line, "\r\n");
        }
    } finally {
        fclose($handle);
    }
}
```

### 7. Keep Composer and deployment reproducible

- Use PSR-4 autoloading and namespaces. Keep application `composer.lock` under version control; follow the repository policy for libraries.
- Make the PHP and extension constraints in `composer.json` match the actual support matrix.
- Prefer the project's existing Composer scripts. Do not add or upgrade dependencies unless the task requires it.
- For a production application, `composer install --no-dev --prefer-dist --optimize-autoloader` reads the lockfile when present, skips `require-dev`, prefers distribution archives, and builds an optimized PSR-4/PSR-0 classmap. Use the framework's deployment command or repository script when one exists; this is not a local development default.
- Treat OPcache settings as deployment decisions. `opcache.validate_timestamps=0` is safe only when deployments reliably restart or invalidate workers.

Completion criterion: dependency resolution, runtime constraints, and deployment behavior agree with the declared support matrix.

## Verification

Run only checks relevant to the change:

- The relevant Composer test or application test command, including failure-path tests, when behavior changes.
- Configured static analysis and formatter checks, such as PHPStan, Psalm, PHP-CS-Fixer, or Pint, when the affected code or project policy requires them.
- `composer validate --strict`, `composer check-platform-reqs`, and `composer audit` when dependencies or Composer configuration change.
- A focused CLI, HTTP, queue, or integration smoke test when the changed behavior has an observable runtime surface.
- A final diff review for accidental API changes, leaked data, missing configuration or deployment steps, unhandled errors, and unsupported PHP syntax.

Completion criterion: relevant targeted checks cover the modified behavior, or the exact unavailable check is reported; the final diff has no unexplained behavior change.

## Quality bar

- Prefer the smallest change that preserves the project's existing architecture.
- Measure before optimizing; profile I/O, memory, and CPU hotspots instead of guessing.
- Let framework and project documentation own HTTP, ORM, session, and framework-testing conventions. Keep this skill focused on PHP language, runtime, security, dependency, and verification behavior.
