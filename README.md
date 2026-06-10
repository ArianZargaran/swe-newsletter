# SWE Newsletter

A self-running daily newsletter bot powered by Claude Code. Each day it picks the next software engineering topic, writes a 400–600 word plain-language newsletter, and emails it via [Resend](https://resend.com). Topic progress is tracked in `CLAUDE.md` and persisted back to this repo after every send.

## How it works

| Day | Category |
|---|---|
| Monday / Friday | Computer Science |
| Tuesday | Software Development |
| Wednesday | Web Development |
| Thursday | AI Engineering |

On each run Claude:
1. Reads `CLAUDE.md` to find the next uncovered topic for today's category
2. Writes the newsletter as HTML (with a tweetable insight at the bottom)
3. Sends it via the Resend API
4. Strikes the topic through in `CLAUDE.md` and pushes the update back to this repo

## Setup

### 1. Fork this repo

### 2. Configure environment variables

Set the following in your Claude Code environment settings:

| Variable | Description |
|---|---|
| `RESEND_API_KEY` | Your [Resend](https://resend.com) API key |
| `GITHUB_TOKEN` | Fine-grained PAT with **Contents: read/write** on this repo |
| `FROM_EMAIL` | Verified sender address in Resend |
| `TO_EMAIL` | Recipient email address |

### 3. Connect to Claude Code

Point a Claude Code remote session at this repo. The session-start hook (`.claude/hooks/session-start.sh`) will automatically pull the latest `CLAUDE.md` — including up-to-date topic state — at the start of every session.

### 4. Run

Trigger a session and instruct Claude to send today's newsletter. It will handle the rest and push the updated tracker back when done.

## Topic lists

Topics live directly in `CLAUDE.md` under four categories. To add, remove, or reorder topics just edit that file — no code changes needed.

## License

MIT
