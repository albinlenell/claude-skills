---
description: Manage Bunny CDN storage and cache — upload files, purge URLs, and list storage contents.
user-invocable: true
argument-hint: "[upload|purge|list] [args]"
allowed-tools:
  - Bash
  - Read
  - Glob
---

# bunny-cdn

Interact with the Bunny CDN API for storage and cache management.

## Trigger

User asks to upload to CDN, purge cache, or list CDN files.

## Prerequisites

Expects these env vars in `.env` or `.env.local` in the working directory:

- `BUNNY_API_KEY` — Account-level API key
- `BUNNY_STORAGE_KEY` — Storage zone password
- `BUNNY_STORAGE_ZONE` — Storage zone name
- `BUNNY_CDN_HOST` — e.g. `storage.bunnycdn.com`

Load them:

```bash
set -a; source .env.local 2>/dev/null || source .env; set +a
```

## Subcommands

### `upload <local-path> <remote-path>`

```bash
curl --fail --silent --show-error --request PUT \
  --url "https://${BUNNY_CDN_HOST}/${BUNNY_STORAGE_ZONE}/${remote_path}" \
  --header "AccessKey: ${BUNNY_STORAGE_KEY}" \
  --header "Content-Type: application/octet-stream" \
  --data-binary "@${local_path}"
```

Print the public URL on success.

### `purge <url>`

```bash
curl --fail --silent --show-error --request POST \
  --url "https://api.bunny.net/purge?url=${url}" \
  --header "AccessKey: ${BUNNY_API_KEY}"
```

### `list <path>`

```bash
curl --fail --silent --show-error --request GET \
  --url "https://${BUNNY_CDN_HOST}/${BUNNY_STORAGE_ZONE}/${path}/" \
  --header "AccessKey: ${BUNNY_STORAGE_KEY}"
```

Format the JSON output as a readable file listing.

## Notes

- On Windows (Git Bash), paths with backslashes must be converted to forward slashes.
- All curl commands include `--fail --silent --show-error` for clean error handling.
