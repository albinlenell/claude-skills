---
description: Scaffold a new Cloudflare Worker project with TypeScript boilerplate, wrangler config, and package.json.
user-invocable: true
argument-hint: "[worker-name]"
allowed-tools:
  - Bash
  - Write
  - Read
---

# worker-scaffold

Create a new Cloudflare Worker from scratch with sensible defaults.

## Trigger

User asks to create a new worker, scaffold a worker, or start a new Cloudflare project.

## Inputs

`$ARGUMENTS` — The worker name (used as directory name and wrangler `name` field).

## Steps

1. **Create directory structure**

   ```
   <worker-name>/
   ├── src/
   │   └── index.ts
   ├── wrangler.toml
   ├── tsconfig.json
   └── package.json
   ```

2. **wrangler.toml**

   ```toml
   name = "<worker-name>"
   main = "src/index.ts"
   compatibility_date = "2025-01-01"
   ```

3. **src/index.ts**

   ```typescript
   export default {
     async fetch(request: Request, env: Env, ctx: ExecutionContext): Promise<Response> {
       return new Response("Hello from <worker-name>!");
     },
   } satisfies ExportedHandler<Env>;

   interface Env {}
   ```

4. **tsconfig.json**

   ```json
   {
     "compilerOptions": {
       "target": "ES2022",
       "module": "ES2022",
       "moduleResolution": "bundler",
       "types": ["@cloudflare/workers-types"],
       "strict": true
     }
   }
   ```

5. **package.json**

   ```json
   {
     "name": "<worker-name>",
     "private": true,
     "scripts": {
       "dev": "wrangler dev",
       "deploy": "wrangler deploy"
     },
     "devDependencies": {
       "wrangler": "^4",
       "@cloudflare/workers-types": "^4"
     }
   }
   ```

6. **Print summary** — list created files, suggest `cd <worker-name> && npm install`.

## Notes

- Does NOT run `npm install` automatically — lets the user decide.
- On Windows, ensure directory paths use forward slashes.
