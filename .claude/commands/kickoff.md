---
description: Fill PLAN, DESIGN, STACK and TECHNICAL-PLAN step by step (if not done in the browser)
---
Help me plan this project. Idea: $ARGUMENTS

Work through these steps one at a time and wait for my approval after each:

1. **PLAN** — Ask me up to 8 questions about goal, users, where it runs, must-haves and constraints. Then fill `CLAUDE/PLAN.md` using its template. No technology choices yet.
2. **DESIGN (optional)** — Say whether this project has a visual side (website, app, game, device screen) and ask if I want a design document. If not, delete `CLAUDE/DESIGN.md` and go to step 3.
   - Ask about mood, references, colours and the section for this project type, max 3 questions at a time.
   - Build a mood board as a small HTML page (`docs/moodboard.html`): palette, fonts and sample elements. Offer 2–3 variants if the direction is open.
   - After I approve it, fill `CLAUDE/DESIGN.md` and keep only the sections for this project type.
3. **STACK** — Propose languages, frameworks and tools based on PLAN.md and DESIGN.md. Give one alternative for each big choice and why you didn't pick it. Every choice references a requirement ID. Then fill `CLAUDE/STACK.md`.
4. **TECHNICAL-PLAN** — Split the work into stages (each ends with something that runs) and phases (each one commit, reviewable in ~10 min). Stage 1 is always the skeleton, plus the theme file if DESIGN.md exists. Every Must have is covered by at least one phase. Then fill `CLAUDE/TECHNICAL-PLAN.md`.
5. Fill the README.md "What it is" line and the HANDOFF.md "Next" section.
