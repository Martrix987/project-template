# Workflow with Claude

How a project goes from idea to commits with Claude (browser) and Claude Code.

## Folders and files
- `CLAUDE.md` — short rules, loaded by Claude Code every session
- `CLAUDE/` — AI context, UPPERCASE names
  - `PLAN.md` — what and why, requirements (Must / Should / Could / Won't)
  - `DESIGN.md` — visual style; only for projects with a UI (delete otherwise)
  - `STACK.md` — languages, tools, commands, style exceptions
  - `TECHNICAL-PLAN.md` — stages and phases with checkboxes
  - `HANDOFF.md` — where the last session stopped
  - `DECISIONS.md` — log of changed choices
- `docs/` — human docs, lowercase names
- `src/`, `tests/` — code and tests (empty until S1P1)
- `.claude/commands/` — slash commands for Claude Code
- `.claude/skills/afk/` — `/afk`: unattended run with Telegram updates
- `.claude/hooks/` — Telegram notifier used by `/afk`
- `.claude/settings.json` — blocks Claude from committing, pushing and reading `.env`
- `.editorconfig`, `.gitattributes`, `.vscode/` — same formatting and line endings everywhere

## 1. Plan in the browser
Uses the claude.ai Project **Project-Kickoff** (instructions + the four templates as project files). One chat per project idea.

1. **Brainstorm** — describe the idea as vague as you like; Claude riffs, suggests and pushes back. No templates yet.
2. **Concept check** — say "let's plan"; Claude sums up the concept in 5–10 bullets. Correct it until it's right.
3. **PLAN** — Claude fills PLAN.md from the brainstorm and only asks about gaps.
4. **DESIGN** (optional) — Claude asks if the project needs one.
   - design questions → mood board (2–3 variants if unsure) → DESIGN.md
5. **STACK** — Claude researches options and fills STACK.md.
6. **TECHNICAL-PLAN** — Claude splits the work into stages and phases.
7. Download the files.

Long, wandering brainstorm? Start a new chat for steps 3–7 and paste only the concept summary.

## Create the repo
1. GitHub or Gitea: new repository from this template
2. Clone it, put the downloaded files in `CLAUDE/` (overwrite the templates)
   - no DESIGN.md made? delete `CLAUDE/DESIGN.md`
3. Commit: `docs: project plan`

No browser? Run `/kickoff <idea>` in Claude Code instead.

## 2. Build with Claude Code
1. Open the repo in Claude Code
2. `/next-phase` — Claude plans the phase, waits for your OK, builds it
3. `/finish-phase` — updates the plan, handoff and docs, proposes a commit message
4. Review the diff, then commit yourself
5. Start a fresh session (`/clear`) every few phases; HANDOFF.md carries the context
6. `/write-doc <topic>` — write a human doc when needed

## AFK runs (work while you're away)
- One-time setup:
  1. Telegram: message `@BotFather` → `/newbot` → copy the token
  2. Send your bot any message, then open `https://api.telegram.org/bot<TOKEN>/getUpdates` → copy `chat.id`
  3. PowerShell: `setx TELEGRAM_BOT_TOKEN "<token>"` and `setx TELEGRAM_CHAT_ID "<id>"`, then restart VS Code / the terminal
- Per run:
  1. Clean working tree on `dev` (commit first)
  2. `/afk` (rest of the stage) or `/afk 3` (next 3 phases)
  3. Answer the questions, approve installs and commands, check the test message arrives
  4. Switch to accept-edits mode (Shift+Tab), keep the laptop plugged in and awake, say `go`
  5. Telegram tells you when it is stuck, waiting for approval, or done
  6. Back: read `CLAUDE/AFK-REPORT.md`, review the diff, commit, run the `/compact` line it gives you

## Branches
- `main` — only finished stages; protected, changes only via pull request
- `dev` — daily work; one commit per phase
- Stage done → pull request `dev` → `main` on GitHub → merge

## Commit messages
- Format: `<type>(<phase-id>): <summary>`
- Types: `feat`, `fix`, `refactor`, `docs`, `test`, `chore`
- Example: `feat(S2P3): read temperature sensor over I2C`

## README rules
- Shared by humans and AI; the first file anyone opens
- Sections: What it is · Quick start · Project structure · Documentation · Status
- Max about one screen; details go in `docs/` and are linked
- Quick start commands must work when copy-pasted

## Keeping it token-light
- `CLAUDE.md` stays under ~80 lines; it is loaded every session
- Don't `@import` big files into CLAUDE.md; that loads them every time
- HANDOFF.md under ~40 lines; it is overwritten, not appended
- Slash commands cost nothing until you use them
- Put a rule in CLAUDE.md only after Claude got it wrong twice

## Using this template
- GitHub: repo Settings → tick "Template repository" → "Use this template" on new projects
- Gitea: repo Settings → tick "Template" → pick it when creating a repo; `$REPO_NAME` is filled in automatically
- On GitHub, replace `$REPO_NAME` / `$REPO_DESCRIPTION` in README.md, CLAUDE.md and PLAN.md by hand
