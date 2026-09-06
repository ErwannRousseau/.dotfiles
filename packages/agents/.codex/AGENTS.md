@~/.codex/RTK.md

@~/.codex/SEMBLE.md

@~/.codex/GRAFT.md

## Tool preferences

For web research:

- When external web research is needed, actively choose between native web
  search and `@Exa` instead of defaulting mechanically to native web search.
- Prefer `@Exa` for technical research, especially for:
  - current library, framework, API, or SDK documentation;
  - GitHub repositories, issues, pull requests, discussions, and changelogs;
  - real-world implementation examples and architecture patterns;
  - undocumented or poorly documented behavior;
  - errors, compatibility issues, migrations, and upgrade paths;
  - niche or hard-to-find technical sources;
  - research requiring multiple searches, source synthesis, or cross-checking.
- Prefer native web search for simple factual lookups, straightforward news or
  current-event checks, locating a known official page, and quick searches where
  deeper source discovery would not add meaningful value.
- When using `@Exa`, write descriptive semantic queries that describe the
  desired source or evidence rather than short keyword queries.
- With `@Exa`, prefer primary sources such as official documentation, source
  repositories, issues, changelogs, specifications, papers, and original
  announcements.
- For non-trivial research, use multiple focused `@Exa` searches when useful,
  then read the most relevant sources instead of relying only on search
  snippets.
- For difficult technical research, prefer `@Exa` over native web search unless
  there is a clear reason not to.

For web QA:

- For any task that requires a manipulation for browsing, use `@Browser` by
  default.
- Do not use Playwright, Puppeteer, Selenium, or browser automation scripts
  unless I explicitly ask for them.
- If `@Browser` is not enough, explain why before using another tool.
- Do not use `@Browser` just for documentation or simple task, it's just
  required for frontend task

For mobile QA:

- For any task that requires interacting with, testing, or validating a React
  Native app on a mobile device or simulator, use `agent-device` by default.
- Before performing any mobile QA interaction, first make sure the correct
  simulator/device is already running, available, and the app is launched or
  launchable through `agent-device`.
- Do not use Browser/Browser Use, Appium, Detox, Maestro, XCUITest, Espresso,
  direct Xcode UI manipulation, `simctl` navigation, shell commands, or custom
  automation scripts to interact with the app unless I explicitly ask for them.
- Do not try alternative navigation methods or launch unnecessary
  Xcode/simulator commands before checking whether `agent-device` can perform
  the task on the already-running simulator.
- If the simulator is not running, start or select the appropriate simulator
  using the minimum necessary action, then continue the QA flow with
  `agent-device`.
- If `agent-device` cannot perform a required action, explain exactly what is
  missing or unsupported before falling back to another tool.
- Do not use `agent-device` for documentation, static code review, or
  implementation tasks that do not require interacting with the running app.
- For React Native frontend QA, `agent-device` should be the source of truth for
  navigation, taps, text input, screenshots, visual validation, user-flow
  testing, bug reproduction, and fix verification.
