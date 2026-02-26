---
description: Deploy a Next.js app running on Cloudflare (via opennextjs-cloudflare) by pushing to main. Verifies build locally first.
user-invocable: true
disable-model-invocation: true
argument-hint: ""
allowed-tools:
  - Bash
  - Read
  - Glob
---

# deploy-next

Deploy a Next.js + opennextjs-cloudflare app via git push (CI/CD).

## Trigger

User explicitly asks to deploy the Next.js app, ship to production, or push to Cloudflare.

## Important

This skill is **not auto-invoked** (`disable-model-invocation: true`). The user must explicitly request it because it pushes to `main` and triggers CI/CD.

## Steps

1. **Check for uncommitted changes**

   ```bash
   if [ -n "$(git status --porcelain)" ]; then
     echo "WARNING: You have uncommitted changes."
     git status --short
   fi
   ```

   Stop and ask the user whether to commit, stash, or abort.

2. **Verify the build**

   ```bash
   npm run build
   ```

   - If the build fails, show the error and stop.
   - If it passes, print: `Build succeeded — safe to deploy.`

3. **Confirm with the user**

   Print a warning:
   > Pushing to `main` will trigger CI/CD and deploy to production.
   > Continue? (user must confirm)

4. **Push**

   ```bash
   git push origin main
   ```

5. **Post-deploy**

   - Print: `Pushed to main. CI/CD deployment triggered.`
   - Suggest checking the Cloudflare dashboard or CI logs.

## Notes

- This does NOT use `wrangler deploy` locally — deployment is via CI/CD pipeline.
- Ensure `opennextjs-cloudflare` is configured in `next.config.mjs`.
- On Windows, `npm run build` may need extra memory: `NODE_OPTIONS=--max-old-space-size=4096`.
