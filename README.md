# claude-skills

Reusable [Claude Code](https://docs.anthropic.com/en/docs/claude-code) skills for my standard stack:

- **Cloudflare Workers** — deploy, KV, DNS
- **Bunny CDN** — file upload, cache purge, pull zones
- **Resend** — transactional email, domain verification
- **Next.js on Cloudflare** — via opennextjs-cloudflare

## Skills included

| Skill | Purpose |
|---|---|
| `deploy-worker` | Deploy a Cloudflare Worker via Wrangler |
| `bunny-cdn` | Manage Bunny CDN storage and cache |
| `resend-email` | Send email or verify domains via Resend |
| `worker-scaffold` | Scaffold a new Worker with boilerplate |
| `deploy-next` | Deploy Next.js app via git push (CI/CD) |

## Installation

### Option A — symlink (recommended)

```bash
# Linux / macOS
ln -s ~/claude-skills/skills ~/.claude/skills

# Windows (Git Bash, run as admin or enable Developer Mode)
bash ~/claude-skills/install.sh
```

### Option B — manual

Copy the `skills/` directory into `~/.claude/skills/` in any project where you want these available.

## Conventions

- Each skill lives in `skills/<name>/SKILL.md`
- Skills are kept under 100 lines
- `allowed-tools` scopes what each skill can access
- Descriptions enable Claude to auto-invoke when relevant
- Designed for Windows 11 + bash (Git Bash / WSL)
