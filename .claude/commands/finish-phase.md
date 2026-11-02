---
description: Close the current phase - update plan, handoff, docs and propose a commit
---
Close the current phase:

1. Confirm build and tests pass; if not, say so and stop.
2. Tick the phase `[x]` in `CLAUDE/TECHNICAL-PLAN.md` and set "Current" to the next phase.
3. Overwrite `CLAUDE/HANDOFF.md` using its template (max ~40 lines).
4. If a choice changed PLAN, STACK or architecture, append one line to `CLAUDE/DECISIONS.md`.
5. Update any `docs/` file or README that this phase made outdated.
6. Show me:
   - a 3–5 bullet summary of what changed
   - a commit message: `<type>(<phase-id>): <summary>`, types: feat, fix, refactor, docs, test, chore
   - plain message only: no Co-Authored-By trailer, no mention of AI or Claude
7. If this was the last phase of a stage, say so: the stage is ready to merge `dev` → `main`.
8. Stop. Do not commit.
