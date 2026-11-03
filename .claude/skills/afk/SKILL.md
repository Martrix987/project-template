---
name: afk
description: Run the rest of a stage or the next few phases unattended - ask everything needed up front, work through the phases, send Telegram updates. Use only when the user runs /afk.
argument-hint: "[stage | N | phase IDs]"
disable-model-invocation: true
---

# AFK run

Work through several phases from `CLAUDE/TECHNICAL-PLAN.md` while the user is away.
Everything that needs the user is collected **before** they leave; after "go" the run must not need them.

Arguments:
- empty or `stage` → all remaining phases of the current stage
- a number `N` → the next N unchecked phases
- phase IDs (`S2P3 S2P4`) → exactly those phases

Notifier: `bash .claude/hooks/telegram-notify.sh "<text>"` (only sends while `.claude/afk.active` exists).
If that script is missing, tell the user the project template is outdated and stop.

## 1. Check the start state
1. `git branch --show-current` must be `dev`. Otherwise stop and tell the user.
2. `git status --porcelain` must be empty. Otherwise ask the user to commit first, then stop.
3. If `CLAUDE/AFK-REPORT.md` says a run is `stuck`, treat this as a **resume**: read the report and HANDOFF, ask the open question again if it is not answered yet, then continue from step 3 with the remaining phases.
4. Read `CLAUDE/HANDOFF.md` and `CLAUDE/TECHNICAL-PLAN.md`; pick the phases in scope. Read `PLAN.md`, `STACK.md` and `DESIGN.md` only for what those phases need.

## 2. Preflight (user is still here)
For every phase in scope, think the implementation through concretely: files, libraries, commands, tests.
Collect everything that would otherwise stop the run:
- **Questions**: unclear requirements, UX or naming choices, edge cases, "what if X fails"
- **New dependencies** not in STACK.md: name, version, why
- **Installs**: packages, SDKs, CLIs, browsers for tests, fonts, assets
- **Commands** the run will execute: build, test, lint, format, dev server, code generators, package manager
- **Risky commands**: deleting files or folders, migrations, anything touching outside the repo, network calls beyond package installs. Prefer a safe alternative; otherwise ask
- **External needs**: accounts, API keys, hardware, files only the user has

Then:
1. Ask the questions in batches of up to 4 (use multiple-choice questions where the tool exists). Record each answer that changes a choice as one line in `CLAUDE/DECISIONS.md`.
2. Add approved dependencies to STACK.md and run the approved installs now, while the user can approve prompts.
3. Show the **AFK contract** and wait for approval:
   - phases in scope, in order
   - the exact command allow rules you will add, e.g. `Bash(npm run build)`, `Bash(npm test *)`
   - what is not allowed: no new dependencies, no risky commands beyond the approved list, no commit, push or branch switch
   - stop rule: the same failure after 3 fix attempts, or a question that blocks all remaining phases
4. After approval, merge the allow rules into `.claude/settings.local.json` (keep existing entries).
5. Create `.claude/afk.active` (content: start time and phase list) and run `bash .claude/hooks/telegram-notify.sh --test`. Ask the user to confirm the message arrived; if not, fix the setup with them first (see `docs/workflow.md`, AFK section).
6. Tell the user: switch to accept-edits mode (Shift+Tab), keep the laptop plugged in and awake, then say `go`.

## 3. Run (user is away)
1. Send: `▶️ AFK started: <first>–<last> (<n> phases)`.
2. Start `CLAUDE/AFK-REPORT.md` fresh (status `running`, phases, start time).
3. For each phase, in order:
   1. Mark it `[~]` in TECHNICAL-PLAN.md
   2. Implement it following CLAUDE.md (scope, style, docs rules)
   3. Run the build and test commands from STACK.md; fix failures, at most 3 attempts per distinct failure
   4. Do the finish-phase steps: tick `[x]`, update HANDOFF.md, DECISIONS.md and docs where needed
   5. Append to AFK-REPORT.md: phase ID, 2–4 bullets of what changed, files touched, proposed commit message `<type>(<phase-id>): <summary>`, anything worth a closer look
4. Never commit, push, switch branch, add unapproved dependencies or run unapproved risky commands. If one is needed, that is a blocker.

### Blockers
- Blocks only this phase and later phases don't depend on it → note it in the report, leave the phase `[~]`, continue with the next independent phase
- Blocks everything → **stop**:
  1. Set report status to `stuck`, write what you tried and exactly what you need
  2. Update HANDOFF.md
  3. Send: `⚠️ Stuck in <phase>: <one-line reason>. Need: <what>`
  4. Remove the flag: `rm .claude/afk.active`
  5. End with the closing message (section 4)

## 4. Finish
1. Run the full build and test suite once more.
2. Set report status to `done` (or `done with notes` if a phase was skipped).
3. Send: `✅ AFK done: <n>/<m> phases, tests <passing|failing>. <one line of notes>`
4. Remove the flag: `rm .claude/afk.active`
5. End with the closing message below.

### Closing message (on done and on stuck)
In this order:
1. **Recap**: per phase one line (done / skipped / stuck) plus the 3–6 most important changes overall, and anything the user should review closely
2. **Commit message** for the next commit (one commit covering this run), plain text, no trailers or AI mentions:
   - all phases of one stage done → `feat(S<n>): <stage summary>` with one body line per phase
   - otherwise → `<type>(<first>–<last>): <summary>` with one body line per phase
   Put it in a code block.
3. **Compact prompt** in its own code block, a single line, so the user can paste it:
   ```
   /compact Keep: current phase <ID or 'none'>, what remains (<phases left, open blockers, user decisions still needed>), key decisions from this run (<short list>), files to look at first (<paths>). Drop: implementation details of finished phases.
   ```
   Fill in the real values; keep it under ~400 characters.