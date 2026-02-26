---
description: Deploy a Cloudflare Worker using Wrangler CLI. Handles wrangler.toml discovery, deployment, and verification.
user-invocable: true
argument-hint: "[worker-name-or-config-path]"
allowed-tools:
  - Bash
  - Read
  - Glob
---

# deploy-worker

Deploy a Cloudflare Worker to production.

## Trigger

User asks to deploy a worker, push a worker, or ship to Cloudflare.

## Inputs

`$ARGUMENTS` — Worker name or path to a `wrangler.toml`. If omitted, use the `wrangler.toml` in the current directory.

## Steps

1. **Resolve config**
   - If `$ARGUMENTS` is a path ending in `.toml`, use it directly.
   - If `$ARGUMENTS` is a name, look for `./$ARGUMENTS/wrangler.toml` or `./wrangler.toml`.
   - If no argument, look for `./wrangler.toml`.
   - Abort if no config is found.

2. **Validate config**
   - Read the `wrangler.toml` and confirm `name` and `main` fields exist.
   - Warn if `compatibility_date` is older than 6 months.

3. **Deploy**
   ```bash
   npx wrangler deploy --config <path-to-wrangler.toml>
   ```

4. **Verify**
   - Check the exit code. If non-zero, show the error output.
   - On success, parse the output for the deployed URL.
   - Print: `Deployed <worker-name> → <url>`

## Notes

- Requires `wrangler` authenticated (`npx wrangler whoami` to check).
- On Windows (Git Bash), ensure `npx` resolves correctly — use `npx.cmd` if needed.
