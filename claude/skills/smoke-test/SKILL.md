---
name: smoke-test
description: Use when an agent has just finished feature work and handed the user a smoke-test plan, or when the user says "/smoke-test", "smoke test this", "smoke test the feature", "verify it in the browser", "click through it for me", or otherwise asks Claude to walk through the manual verification steps itself instead of doing them. Boots the local dev environment, drives Chrome through the smoke-test instructions the previous turn provided, collects every issue found into a single triaged report, and waits for the user's direction before fixing anything.
---

# Smoke Test — Drive The Verification, Don't Skip Ahead To Fixes

The previous assistant turn finished a feature and gave the user a smoke-test
plan. The user has handed that plan back: **you** run it now, in a real dev
environment, in Chrome, end-to-end. You watch what happens, write down what's
broken, and report. You do **not** start fixing things mid-walkthrough.

The whole value of this skill is the discipline of *observe everything first,
fix afterward*. Mid-run fixes contaminate the rest of the smoke test (was the
later failure caused by the original bug, or by your half-applied patch?), and
they rob the user of the chance to triage. A good smoke-test pass produces one
clean report, not a trail of half-fixed regressions.

## When this skill applies

- The most recent assistant turn ended with smoke-test / verification steps
  for the user to perform manually.
- The user replied with `/smoke-test`, "smoke test this", "you do it", "run
  through it yourself", "verify in the browser", or similar.
- The user wants Claude to take over the walkthrough rather than do it
  themselves.

## When NOT to use

- The user is asking you to *write* a smoke-test plan, not execute one →
  draft a plan in chat; don't boot anything.
- There is no smoke-test plan in the recent conversation **and** the user
  hasn't given you one → ask the user for the steps before booting anything.
  Don't invent steps.
- The feature is backend-only with no browser surface → run the relevant
  command-line check or curl probe instead; this skill is for browser flows.
- Production or any shared environment is the target → stop. This skill is
  local-dev only.

## Required tools

This skill drives a real browser. You need an MCP that exposes Chrome — the
`Claude_in_Chrome` MCP (`mcp__Claude_in_Chrome__*` tools) is the primary
target; `Claude_Preview` (`mcp__Claude_Preview__*`) is an acceptable fallback
for projects that ship a built-in preview.

If neither is available, stop and tell the user: *"I can't drive the browser
from here — `Claude_in_Chrome` (or `Claude_Preview`) isn't connected. Want me
to walk through the smoke test by reading code and curling endpoints
instead?"* Don't fake it.

## Checklist

Create a TodoWrite todo for each item and complete in order. Do not skip
ahead — the report-before-fix gate is the entire point of this skill.

1. **Recover the smoke-test plan** — find the verification steps from the
   prior turn (or ask the user)
2. **Inventory the dev environment** — read `package.json` / `CLAUDE.md` /
   `README.md` to learn how this project starts
3. **Pull latest + install** — make sure dependencies and codegen are current
4. **Start the dev server in the background** — capture logs to a file you
   can tail
5. **Wait for the server to be ready** — poll the health URL; don't just sleep
6. **Connect to Chrome** — pick or open a browser tab on the dev URL
7. **Walk the smoke-test steps in order** — one at a time, capturing
   evidence (screenshots, console, network) as you go
8. **Log every issue to the issue queue** — do not stop, do not fix
9. **Stop conditions** — only halt early if the app is unreachable or a step
   is impossible to perform
10. **Triage and report** — group issues by severity, propose resolutions,
    present the full report
11. **Wait for the user's direction** — they choose what (if anything) to fix
12. **Tear down on request** — leave the dev server running unless the user
    asks you to stop it

## Process flow

```
recover plan -> inventory env -> install + generate -> start dev server (bg)
  -> wait for ready -> connect Chrome -> walk steps (queue issues, never fix)
  -> triage -> report -> wait for user -> (optionally) fix
```

## Step 1 — Recover the smoke-test plan

The plan is almost always in the previous assistant turn. Scan the
conversation for things like "Smoke test:", "To verify:", "Try this:", or a
numbered list of click-through steps.

Extract each step verbatim. Number them. If a step is ambiguous ("check the
page renders correctly"), write down what specifically you'll look for
(visible heading, no console errors, no 4xx/5xx in network) so the user can
later see what "correctly" meant to you.

If you genuinely cannot find a plan, ask the user for it. Don't guess — a
fabricated smoke test verifies nothing.

## Step 2 — Inventory the dev environment

Read the project's source-of-truth docs in this order:

1. `CLAUDE.md` (project conventions — often spells out the dev command)
2. `README.md`
3. `package.json` `scripts` (or `Makefile`, `justfile`, `mise.toml`,
   `Procfile`, `docker-compose.yml`)

You're answering four questions:

- **Install command** — `pnpm install`, `npm ci`, `bun install`, etc. Use
  the package manager the repo specifies. Don't substitute.
- **Codegen / migration step** — `pnpm generate`, `prisma migrate dev`,
  `supabase db reset`, etc.
- **Dev command** — `pnpm dev`, `npm run dev`, `bun dev`, `make dev`.
- **Dev URL** — usually `http://localhost:3000`, but check for
  framework-specific defaults (`5173` for Vite, `8080`, `4000`, etc.) or a
  `.env*` override.

If `CLAUDE.md` says "one command does everything" (e.g. `pnpm dev`), trust
it. Don't run codegen separately.

## Step 3 — Pull latest + install

If the user asked for a smoke test on a branch they just finished, the tree
is already correct — don't `git pull` or switch branches. Just install and
generate so the lockfile and generated types are current:

```bash
<install command>
```

If install fails, that **is** an issue. Add it to the issue queue and stop —
you can't smoke-test what won't install. Surface it immediately and ask the
user how to proceed.

## Step 4 — Start the dev server in the background

Use `Bash` with `run_in_background: true`. Tee output to a log file so you
can read it later without holding a foreground process:

```bash
<dev command> > /tmp/smoke-test-dev.log 2>&1
```

Capture the background shell ID. You'll need it to inspect logs and to stop
the server on cleanup.

If the project uses multiple processes (e.g. Inngest + Next), one combined
dev script (often via `concurrently`) is fine — that's already a single
background process. If they're truly separate, start each one in the
background and track all their IDs.

## Step 5 — Wait for the server to be ready

Don't sleep blindly. Poll the dev URL until it returns a 2xx/3xx, with a
timeout of ~60 seconds:

```bash
until curl -sf -o /dev/null http://localhost:3000; do sleep 2; done
```

If it never comes up, read the log file and surface the failure. Don't move
on to "connect to Chrome" against a server that isn't running.

## Step 6 — Connect to Chrome

Prefer `Claude_in_Chrome`. Typical sequence:

1. `mcp__Claude_in_Chrome__list_connected_browsers` — see what's available
2. `mcp__Claude_in_Chrome__navigate` to the dev URL (or open a new tab)
3. `mcp__Claude_in_Chrome__read_console_messages` baseline — note any errors
   that exist *before* you do anything, so you can distinguish pre-existing
   noise from issues your steps caused

If the project has its own preview MCP (`Claude_Preview`), use that instead.
The flow is the same: open the URL, take a baseline, then start the script.

## Step 7 — Walk the smoke-test steps in order

For each step from the recovered plan:

1. Perform the action (click, fill, navigate). Use the smallest tool that
   does the job — `preview_click` / `preview_fill` for simple cases,
   `javascript_tool` only when DOM state is unreachable otherwise.
2. Wait for the page to settle (network idle, expected element visible).
3. Capture evidence:
   - `screenshot` after each meaningful state change
   - `read_console_messages` to pick up new JS errors
   - `read_network_requests` to spot 4xx/5xx
4. Compare what you see against what the step said should happen.

Keep the loop tight: action → observe → record → next step.

**Auth.** If the smoke test requires being signed in, use whatever local-dev
auth the project provides (e.g. a `DEV_AUTH_ENABLED` flow, a seeded test
user, or a magic-link in the inbox). Never paste real credentials. If there
is no local-dev auth path, that itself is an issue worth recording before
giving up on the rest of the run.

## Step 8 — Log every issue to the issue queue

Maintain a structured list. For each problem, capture:

```
- step: <step number from the plan>
  observed: <what actually happened>
  expected: <what the plan said should happen>
  severity: blocker | major | minor | nit
  evidence: <screenshot path / log line / failing request>
  hypothesis: <one-line guess at the cause, if obvious>
```

Severity rubric:

- **blocker** — feature is unusable; primary happy path fails
- **major** — feature works but a documented case (in the plan) is broken
- **minor** — visible glitch, console warning, layout issue, slow but
  functional
- **nit** — copy, spacing, polish

**Never fix mid-walkthrough.** Even if the fix looks one-line and obvious,
record it and move on. A patched-and-restarted server invalidates the
remaining steps.

The only exceptions are *infrastructure* failures that prevent any further
testing: install fails, dev server won't start, Chrome MCP can't connect.
For those, stop and report immediately — there's nothing left to test.

## Step 9 — Stop conditions

Run all steps even when individual ones fail. Stop early only when:

- Dev server is down and won't restart
- A blocker prevents progressing past step N (e.g. login is broken and
  every other step needs auth) — note the dependency, run any steps that
  *don't* require it, then stop
- The user interrupts and tells you to stop

When you stop early, say so explicitly in the report. Don't pretend an
un-run step passed.

## Step 10 — Triage and report

Group issues by severity (blockers first). For each one, propose a
resolution at the right depth:

- **Mechanical fixes** (typo, wrong import, missing prop): one-line
  description.
- **Logic bugs**: one-paragraph hypothesis with the file/function name if
  you've already located it.
- **Unclear root cause**: say so honestly. "Reproduces, cause unknown,
  needs debugging" is a valid resolution.

Use this report template:

```markdown
## Smoke test report

**Branch / feature:** <branch or feature name>
**Dev server:** <status — running / stopped>
**Steps run:** <N of M> (<reason if not all>)

### Blockers
1. **<short title>** — step <n>
   - Observed: …
   - Expected: …
   - Evidence: <screenshot / log / request>
   - Suggested fix: …

### Major
…

### Minor
…

### Nits
…

### What I did NOT touch
I logged everything above without making any code changes. Tell me which
items to fix and in what order, or say "fix the blockers" / "fix
everything" and I'll start.
```

Keep it scannable. Long descriptions go under the bullet, not in the
heading.

## Step 11 — Wait for the user's direction

This is the gate. The user reads the report and chooses:

- "Fix the blockers" → fix only severity=blocker items, then re-run the
  affected steps
- "Fix everything" → fix in order: blocker → major → minor → nit
- "Just fix #2 and #4" → fix the named items
- "I'll handle these myself" → leave the code alone, optionally tear down
  the dev server

Do **not** start fixing before the user replies. "Fixing the obvious one
while we wait" is exactly the failure mode this skill exists to prevent —
it tangles the issue queue and forces the user to re-triage against a
moving target.

## Step 12 — Tear down on request

By default, leave the dev server running — the user often wants to poke at
it themselves after reading the report. Tear down only when:

- The user asks
- You started the server *and* the report shows the server is unusable
  (in which case mention you stopped it)

Stop background processes by their shell ID. Don't `pkill` blindly — the
user may have other dev work running.

## Common mistakes

| Mistake | Fix |
|---|---|
| Fixing a bug as soon as you see it | Add to queue, keep going. The whole skill exists to prevent this. |
| Skipping the dev-server readiness poll, then "connecting" to a 502 | Always poll until 2xx/3xx before navigating. |
| Inventing smoke-test steps because you can't find the plan | Ask the user. Made-up steps test nothing. |
| Reporting "looks good" without screenshots | Capture evidence even on success. The user can't see what you saw. |
| Running `pnpm install` when the project uses `npm` (or vice versa) | Use the package manager the repo specifies. Mixed lockfiles are a separate, worse bug. |
| Using `--no-verify` or `--force` to "make it work" | That's a red flag, not a workaround. Record the failure and surface it. |
| Pasting your real credentials into a login form | Stop. Use the project's local-dev auth path, or report that none exists. |

## Red flags — stop and reconsider

- About to apply a fix mid-walkthrough → STOP. Add to the queue, finish the
  walk.
- About to skip a step because "it probably works" → run it. The whole
  point is observation.
- About to claim success without capturing a screenshot → take the
  screenshot first.
- Dev server failed to start and you're considering switching to "I'll just
  read the code" → that's a different (legitimate) activity, but not a
  smoke test. Tell the user the smoke test couldn't run, *then* offer the
  alternative.
- About to commit, push, or open a PR after fixing → you weren't asked.
  Report what you fixed and stop.

## Notes

- This skill is for **local development only**. Never run it against a
  staging or production URL, even if the user asks — push back and confirm.
- It does not write tests, open PRs, or commit changes on its own.
- It is fine to run multiple iterations: smoke → fix → re-smoke. Each
  re-smoke starts the checklist over from step 7 (server is already up;
  re-walk the affected steps).
