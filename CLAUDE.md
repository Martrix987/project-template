# $REPO_NAME

<!-- Loaded into every Claude Code session. Keep it under ~80 lines. -->
<!-- Details live in CLAUDE/ and are read only when needed. -->

## Project
- One line: what this is → see `CLAUDE/PLAN.md`
- Stack, build and run commands → see `CLAUDE/STACK.md`
- Visual style → see `CLAUDE/DESIGN.md` (if it exists); read it before any UI work

## Session start
1. Read `CLAUDE/HANDOFF.md` (where we left off)
2. Read the current stage in `CLAUDE/TECHNICAL-PLAN.md`
3. Read other files only when the task needs them

## Work loop (one phase at a time)
- All work happens on the `dev` branch; never switch to or change `main`
- Work on exactly one phase from `CLAUDE/TECHNICAL-PLAN.md`
- Stay inside the phase scope; note out-of-scope ideas in HANDOFF under "Later"
- When the phase is done:
  - make sure it builds / tests pass (commands in STACK.md)
  - tick the phase checkbox in TECHNICAL-PLAN.md
  - update HANDOFF.md
  - propose a commit message, then **stop and wait**
- Never commit, push or rewrite git history yourself
- Commit messages, README, `docs/` and code comments never mention AI, Claude or co-authors
- Ask before adding a dependency that is not in STACK.md
- Ask instead of guessing when a requirement in PLAN.md is unclear

## Coding style (all languages)
- Readability first: clear names over clever code
- Naming:
  - variables, functions, methods: `camelCase`
  - classes, structs, types, enums: `PascalCase`
  - constants and macros: `UPPER_SNAKE_CASE`
  - file and folder names: `lowercase`, words split with `-` (or `_` where the language requires it)
  - per-language exceptions are listed in STACK.md, nowhere else
- Layout: 4 spaces, no tabs, max ~100 chars per line, braces on the same line
- One blank line between logical blocks; group code like paragraphs
- Small functions that do one thing; return early instead of deep nesting
- No magic numbers: name them as constants
- UI colours, fonts and durations only come from the theme file named in DESIGN.md
- Comments explain *why*, not *what*; every file starts with a 1–3 line header saying its purpose
- Handle errors explicitly; never swallow them silently
- Match the existing style of a file before applying these rules to it

## Documentation rules
- `docs/` = human docs
  - lowercase names: `docs/setup.md`, `docs/how-it-works.md`
  - short, bullet points and numbered steps
  - no padding, no repeated info, no decorative tables or diagrams
  - a small CSV or one diagram only when it explains more than text can
- `CLAUDE/` = AI context, plans and handoffs
  - UPPERCASE names: `CLAUDE/PLAN.md`
  - complete and precise; written for the next session, not for show
- `README.md` = shared entry point (rules in `docs/workflow.md`)
- Update docs in the same phase as the code they describe
- Never duplicate content between files; link to it instead
