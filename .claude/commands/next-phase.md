---
description: Start the next (or a given) phase from TECHNICAL-PLAN.md
---
Start phase $ARGUMENTS (if empty: the first unchecked phase in `CLAUDE/TECHNICAL-PLAN.md`).

1. Read `CLAUDE/HANDOFF.md` and the phase entry. Read PLAN.md / STACK.md only for the requirements it covers.
2. Mark the phase `[~]` and give me a short plan: files you will touch and how you check "Done when". Wait for my OK.
3. Implement only this phase, following the style rules in CLAUDE.md.
4. Run the build and test commands from STACK.md and fix failures.
5. Run /finish-phase.
