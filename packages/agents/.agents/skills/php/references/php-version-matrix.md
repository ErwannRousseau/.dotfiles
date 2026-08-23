# Selected PHP version matrix

This is a selection of high-leverage language and standard-library features, not a complete list of PHP changes. Choose features from the lowest PHP version the project supports. Inspect `composer.json`, CI, Dockerfiles, `.php-version`, and the production runtime before using syntax or APIs.

| Runtime floor | Features worth considering |
| --- | --- |
| PHP 8.0 | Attributes, constructor property promotion, named arguments, union types, `match`, nullsafe access, throw expressions |
| PHP 8.1 | Enums, readonly properties, intersection types, `never`, fibers |
| PHP 8.2 | Readonly classes, disjunctive normal form types, `#[\SensitiveParameter]`, `Random\Randomizer`; avoid dynamic properties |
| PHP 8.3 | Typed class constants, `#[\Override]`, `json_validate()`, readonly amendments |
| PHP 8.4 | Property hooks, asymmetric property visibility, lazy objects, `#[\Deprecated]`, `RoundingMode` |
| PHP 8.5 | URI APIs, the pipe operator `|>`, `clone()` with property updates, `array_first()`/`array_last()`, `#[\NoDiscard]` |

This is a selection guide, not a compatibility promise. Confirm extension availability, dependency constraints, framework support, and the project's CI matrix before adopting a newer feature. For exhaustive new features, deprecations, removals, and backward-incompatible changes, use the official migration guides for [PHP 8.0](https://www.php.net/manual/en/migration80.php), [8.1](https://www.php.net/manual/en/migration81.php), [8.2](https://www.php.net/manual/en/migration82.php), [8.3](https://www.php.net/manual/en/migration83.php), [8.4](https://www.php.net/migration84), and [8.5](https://www.php.net/manual/en/migration85.php).

When the project targets a version newer than this matrix, consult the corresponding official PHP migration guide before using new language or standard-library features.
