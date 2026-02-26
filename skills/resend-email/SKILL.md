---
description: Send transactional email or verify domain configuration via the Resend API.
user-invocable: true
argument-hint: "[send|domains] [args]"
allowed-tools:
  - Bash
  - Read
---

# resend-email

Send email and manage domains through the Resend API.

## Trigger

User asks to send a test email, check email config, or verify a domain with Resend.

## Prerequisites

Expects `RESEND_API_KEY` in `.env`, `.env.local`, or shell environment.

```bash
set -a; source .env.local 2>/dev/null || source .env; set +a
```

## Subcommands

### `send <to> <subject>`

Send a test/transactional email.

```bash
curl --fail --silent --show-error --request POST \
  --url https://api.resend.com/emails \
  --header "Authorization: Bearer ${RESEND_API_KEY}" \
  --header "Content-Type: application/json" \
  --data "{
    \"from\": \"onboarding@resend.dev\",
    \"to\": \"${to}\",
    \"subject\": \"${subject}\",
    \"html\": \"<p>Test email sent via Claude skill at $(date -u +%Y-%m-%dT%H:%M:%SZ)</p>\"
  }"
```

- Parse the response for `id` to confirm delivery.
- Print: `Email sent → id: <id>`

### `domains`

List and verify domain configuration.

```bash
curl --fail --silent --show-error --request GET \
  --url https://api.resend.com/domains \
  --header "Authorization: Bearer ${RESEND_API_KEY}"
```

- Display each domain, its status, and any missing DNS records.
- If a domain is `pending`, show the required DNS records.

## Notes

- Change the `from` address once you have a verified domain.
- Rate limits apply — Resend free tier: 100 emails/day.
- On Windows (Git Bash), ensure `curl` is available (ships with Git for Windows).
