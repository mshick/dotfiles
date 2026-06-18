---
name: smoke-test-recorded
description: Use when the user wants a smoke test walkthrough captured as a recording — they say "/smoke-test-recorded", "smoke test this and record it", "record the smoke test", "smoke test with a recording", "give me a GIF of the walkthrough", or otherwise asks Claude to both run the manual verification steps AND hand back a video/GIF artifact of the run. Same discipline as the plain smoke-test skill (boot the local dev env, drive Chrome through the plan, collect every issue into one triaged report, wait for direction before fixing) — plus it records the browser session with the Claude_in_Chrome gif_creator and attaches the exported GIF to the report.
---

# Smoke Test (Recorded) — Drive The Verification, Capture It, Don't Skip Ahead To Fixes

This is the [smoke-test](../smoke-test/SKILL.md) skill with one addition: the
whole browser walkthrough is **recorded as a GIF** so the user gets a visual
artifact of the run alongside the written report.

Everything that makes the plain smoke test valuable still holds: **you** run
the plan, in a real dev environment, in Chrome, end-to-end. You watch what
happens, write down what's broken, and report. You do **not** start fixing
things mid-walkthrough — the recording would capture a contaminated run, and
mid-run fixes rob the user of the chance to triage. A good recorded smoke-test
pass produces one clean report and one clean GIF, not a trail of half-fixed
regressions.

## When this skill applies

- The user wants the smoke-test walkthrough **recorded** — they asked for a
  GIF, a video, a recording, or a visual artifact of the run.
- The most recent assistant turn ended with smoke-test / verification steps,
  and the user replied with `/smoke-test-recorded`, "record it", "smoke test
  and capture it", or similar.

If the user just wants the walkthrough run with no recording, use the plain
[smoke-test](../smoke-test/SKILL.md) skill instead — don't add recording
overhead they didn't ask for.

## When NOT to use

- The user is asking you to *write* a smoke-test plan, not execute one →
  draft a plan in chat; don't boot anything.
- There is no smoke-test plan in the recent conversation **and** the user
  hasn't given you one → ask the user for the steps before booting anything.
  Don't invent steps.
- The feature is backend-only with no browser surface → there's nothing to
  record. Run the relevant command-line check or curl probe instead, and tell
  the user a recording doesn't apply.
- Production or any shared environment is the target → stop. This skill is
  local-dev only.

## Required tools

This skill drives **and records** a real browser, so it needs the
`Claude_in_Chrome` MCP specifically — the recording depends on
`mcp__Claude_in_Chrome__gif_creator`, which has no equivalent in
`Claude_Preview`. The driving tools you'll use are the usual
`mcp__Claude_in_Chrome__*` set (`navigate`, `read_page`, `read_console_messages`,
`read_network_requests`, `computer`/`form_input`, `gif_creator`).

If `Claude_in_Chrome` is **not** connected, stop and tell the user: *"I can't
record the smoke test from here — the `Claude_in_Chrome` MCP isn't connected,
and that's the only browser MCP that can capture a GIF. I can run the
walkthrough without a recording via the plain smoke-test skill, or read the
code and curl endpoints instead. Which would you like?"* Don't fake it, and
don't silently downgrade to an un-recorded run — the recording is the reason
this variant exists.

## Checklist

Create a TodoWrite todo for each item and complete in order. Do not skip
ahead — the report-before-fix gate is the entire point of this skill, and the
recording must wrap the *entire* walk (start before step 1 of the plan, stop
after the last step) or it'll be missing frames.

1. **Recover the smoke-test plan** — find the verification steps from the
   prior turn (or ask the user)
2. **Inventory the dev environment** — read `package.json` / `CLAUDE.md` /
   `README.md` to learn how this project starts
3. **Pull latest + install** — make sure dependencies and codegen are current
4. **Start the dev server in the background** — capture logs to a file you
   can tail
5. **Wait for the server to be ready** — poll the health URL; don't just sleep
6. **Connect to Chrome** — pick or open a browser tab on the dev URL, take a
   baseline of console/network
7. **Start the GIF recording** — begin capturing *before* the first plan step
8. **Walk the smoke-test steps in order** — one at a time, capturing
   evidence (screenshots, console, network) as you go
9. **Log every issue to the issue queue** — do not stop, do not fix
10. **Stop conditions** — only halt early if the app is unreachable or a step
    is impossible to perform
11. **Stop and export the recording** — end capture, export the annotated GIF,
    note where it landed
12. **Triage and report** — group issues by severity, propose resolutions,
    attach the recording, present the full report
13. **Wait for the user's direction** — they choose what (if anything) to fix
14. **Tear down on request** — leave the dev server running unless the user
    asks you to stop it

## Process flow

```
recover plan -> inventory env -> install + generate -> start dev server (bg)
  -> wait for ready -> connect Chrome (baseline) -> START RECORDING
  -> walk steps (queue issues, never fix) -> STOP + EXPORT RECORDING
  -> triage -> report (with GIF) -> wait for user -> (optionally) fix
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
fabricated smoke test verifies nothing, and a recording of a fabricated run
is worse than nothing.

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
user how to proceed. (No recording yet, so nothing to clean up.)

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

Use `Claude_in_Chrome`. Typical sequence:

1. `mcp__Claude_in_Chrome__list_connected_browsers` — see what's available
2. `mcp__Claude_in_Chrome__navigate` to the dev URL (or open a new tab). Note
   the **tab ID** — `gif_creator` is scoped to a tab group and needs it on
   every call.
3. `mcp__Claude_in_Chrome__read_console_messages` baseline — note any errors
   that exist *before* you do anything, so you can distinguish pre-existing
   noise from issues your steps caused.

Do the baseline read *before* you start recording so the GIF opens on the
first real plan step, not on setup noise.

## Step 7 — Start the GIF recording

Begin capturing now, while the page is sitting at its clean starting state and
*before* you perform the first step of the plan:

1. `mcp__Claude_in_Chrome__gif_creator` with `action: "start_recording"` and
   the `tabId` from step 6.
2. Immediately take a screenshot (`mcp__Claude_in_Chrome__computer` screenshot,
   or your usual screenshot call) — the gif_creator uses the screenshot taken
   right after `start_recording` as the **first frame**, so this is what
   anchors the opening of the GIF.

From here on, every click/fill/navigate you do during the walk is captured
automatically — `gif_creator` records browser actions (clicks, scrolls,
navigation) within the tab group, so you don't call it again until you stop.

If `start_recording` errors, don't abandon the walk — record that the
recording couldn't start (it's worth telling the user), then decide with the
user whether to proceed un-recorded or stop. Surface it; don't silently run
without the GIF the user asked for.

## Step 8 — Walk the smoke-test steps in order

For each step from the recovered plan:

1. Perform the action (click, fill, navigate). Use the smallest tool that
   does the job. The recording is already running — no extra calls needed per
   action, but do keep actions deliberate and paced so the GIF is legible
   (a flurry of rapid-fire actions makes an unreadable recording).
2. Wait for the page to settle (network idle, expected element visible).
3. Capture evidence:
   - a screenshot after each meaningful state change (these also help anchor
     frames in the recording)
   - `read_console_messages` to pick up new JS errors
   - `read_network_requests` to spot 4xx/5xx
4. Compare what you see against what the step said should happen.

Keep the loop tight: action → observe → record → next step.

**Auth.** If the smoke test requires being signed in, use whatever local-dev
auth the project provides (e.g. a `DEV_AUTH_ENABLED` flow, a seeded test
user, or a magic-link in the inbox). Never paste real credentials — and be
aware the recording is live, so never type a real secret into a field while
capturing. If there is no local-dev auth path, that itself is an issue worth
recording (in the issue queue) before giving up on the rest of the run.

## Step 9 — Log every issue to the issue queue

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
remaining steps *and* splices a broken-then-working sequence into the GIF that
misleads anyone watching it.

The only exceptions are *infrastructure* failures that prevent any further
testing: dev server dies, Chrome MCP can't connect. For those, stop the
recording (step 11), export whatever you captured, and report immediately —
there's nothing left to test.

## Step 10 — Stop conditions

Run all steps even when individual ones fail. Stop early only when:

- Dev server is down and won't restart
- A blocker prevents progressing past step N (e.g. login is broken and
  every other step needs auth) — note the dependency, run any steps that
  *don't* require it, then stop
- The user interrupts and tells you to stop

When you stop early, say so explicitly in the report, and still export the
partial recording — a GIF of the run up to the blocker is useful evidence.
Don't pretend an un-run step passed.

## Step 11 — Stop and export the recording

Once the walk is done (whether it completed or stopped early):

1. Take a final screenshot of the last state — the gif_creator uses the
   screenshot taken right *before* `stop_recording` as the **last frame**.
2. `mcp__Claude_in_Chrome__gif_creator` with `action: "stop_recording"` and
   the `tabId`. This stops capture but keeps the frames.
3. `mcp__Claude_in_Chrome__gif_creator` with `action: "export"`, the `tabId`,
   `download: true`, and a descriptive `filename` (e.g.
   `smoke-test-<feature>-<branch>.gif`). The annotation defaults are usually
   what you want — click indicators, action labels, and a progress bar make
   the run readable. Drop the watermark only if the user asks.

Note the path the GIF downloaded to so you can reference it in the report. If
export fails, retry once; if it still fails, say so plainly in the report
(the written walkthrough still stands) rather than blocking on it.

Don't `clear` the frames until you're sure the export succeeded — that's your
only copy.

## Step 12 — Triage and report

Group issues by severity (blockers first). For each one, propose a
resolution at the right depth:

- **Mechanical fixes** (typo, wrong import, missing prop): one-line
  description.
- **Logic bugs**: one-paragraph hypothesis with the file/function name if
  you've already located it.
- **Unclear root cause**: say so honestly. "Reproduces, cause unknown,
  needs debugging" is a valid resolution.

Lead the report with the recording so the user can watch the run before
reading the findings. Use this template:

```markdown
## Smoke test report (recorded)

**Branch / feature:** <branch or feature name>
**Recording:** <path to exported GIF> (<note if partial / export failed>)
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

## Step 13 — Wait for the user's direction

This is the gate. The user reads the report, watches the recording, and
chooses:

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

## Step 14 — Tear down on request

By default, leave the dev server running — the user often wants to poke at
it themselves after reading the report. Tear down only when:

- The user asks
- You started the server *and* the report shows the server is unusable
  (in which case mention you stopped it)

Stop background processes by their shell ID. Don't `pkill` blindly — the
user may have other dev work running.

If you want a fresh recording for a re-smoke after fixes, start a new
`gif_creator` recording at step 7 of the re-run — don't try to append to the
old one.

## Common mistakes

| Mistake | Fix |
|---|---|
| Forgetting to start recording, so the report has no GIF | Start recording (step 7) is its own checklist item *before* the first plan step. Don't merge it into the walk. |
| Starting the recording before the baseline, so the GIF opens on setup noise | Baseline console/network read first, then `start_recording`, then the first plan step. |
| `clear`ing or discarding frames before confirming the export landed | Export and verify the path first; the captured frames are your only copy. |
| Fixing a bug as soon as you see it | Add to queue, keep going. The whole skill exists to prevent this — and a mid-run fix splices a misleading sequence into the GIF. |
| Skipping the dev-server readiness poll, then "connecting" to a 502 | Always poll until 2xx/3xx before navigating. |
| Inventing smoke-test steps because you can't find the plan | Ask the user. Made-up steps test nothing, and a recording of them is worse. |
| Silently running without the GIF when `Claude_in_Chrome` is missing | The recording is why this variant exists. Surface the problem and let the user choose plain smoke-test or stop. |
| Pasting your real credentials into a login form (now also on camera) | Stop. Use the project's local-dev auth path, or report that none exists. |

## Red flags — stop and reconsider

- About to walk the plan but never called `start_recording` → STOP. Start the
  recording first; that's the entire difference from the plain skill.
- About to apply a fix mid-walkthrough → STOP. Add to the queue, finish the
  walk, then export the recording.
- About to skip a step because "it probably works" → run it. The whole point
  is observation (and a complete recording of it).
- About to claim success without capturing a screenshot → take the screenshot
  first; it also anchors a frame in the GIF.
- About to `clear` the gif frames before the export succeeded → don't; you'll
  lose the recording.
- Dev server failed to start and you're considering switching to "I'll just
  read the code" → that's a different (legitimate) activity, but not a
  recorded smoke test. Tell the user it couldn't run, *then* offer the
  alternative.
- About to commit, push, or open a PR after fixing → you weren't asked.
  Report what you fixed and stop.

## Notes

- This skill is for **local development only**. Never run it against a
  staging or production URL, even if the user asks — push back and confirm.
- It does not write tests, open PRs, or commit changes on its own.
- It is fine to run multiple iterations: smoke → fix → re-smoke. Each
  re-smoke starts a fresh recording (new `start_recording` at step 7) and
  re-walks the affected steps; the server is already up.
- The GIF is an artifact for the user to review and share — treat it as part
  of the deliverable, not an afterthought. A report that says "recording
  failed to export" should explain why, not bury it.
