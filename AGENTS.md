# Global Codex Rules (Repo‑Wide)

These rules guide agent work across this entire repository. They apply to all directories and files unless a more specific AGENTS.md in a subfolder overrides them.

## Scope & Intent
- Keep changes small, focused, and idiomatic to the repo.
- Prefer surgical edits over refactors unless explicitly requested.
- Never commit raw secrets. Use `secrets/` with agenix and keys from `meta.nix`.

## Workflow Preferences
- Planning: Use the plan tool for multi‑step tasks; skip for trivial changes.
- Validation: Treat builds as tests. Prefer build over switch unless asked.
  - NixOS build: `nixos-rebuild build --flake .#<host>`
  - Home Manager build: `home-manager build --flake .#<user@host>`
- Switching: Do not run `switch` unless explicitly requested by the user.
- Lint/format before committing (or rely on lefthook):
  - `alejandra *.nix`
  - `deadnix --fail .`
  - `statix check .`
- Commits: Use Conventional Commits. Common scopes: `hm:`, `nixos:`, `fix(<host>):`.
- Searches: Prefer `rg` for file/content searches.
- Read files in chunks ≤250 lines when quoting output.
- To apply stow, use command "stow.sh". it's under ./scripts and is added to PATH.

## Nix Conventions
- Formatting: `alejandra` is authoritative (2‑space indent, trailing commas where idiomatic).
- Paths: Do not hardcode binary paths; prefer `${lib.getExe pkgs.<pkg>}` or `${pkgs.<pkg>}/bin/<exe>`.
- Structure:
  - Root entrypoint: `flake.nix` (dev shell, `homeConfigurations`, `nixosConfigurations`).
  - Home Manager: `home-manager/` with `profiles/`, `features/`, `store/`.
  - NixOS: `nixos/` with `hosts/<name>/`, `core/`, `profiles/` (see `nixos/default.nix`).
  - Dotfiles to stow: `stow/`.
  - Shared bits: `shared/`. Local packages: `my/pkgs/`.
- Modules should be small/composable. Host specifics live under `nixos/hosts/<host>/` or `home-manager/profiles/`.

## Security
- Secrets policy: add `.age` files under `secrets/` and register in `secrets/secrets.nix`; keys from `meta.nix`.
- Validate with `deadnix`/`statix`; avoid unused or dangling options.

## Commit & PR Guidance
- Conventional Commits examples:
  - `hm(<feature>): <summary>`
  - `nixos(<host>|core|profile): <summary>`
  - `fix(<host>): <summary>`
- PRs should include: summary, affected hosts/profiles, before/after notes, and screenshots for desktop changes.

## Agent Behavior Defaults
- Be concise and direct; include a short preamble before running tools.
- Use `apply_patch` for file changes; keep diffs minimal.
- Do not add unrelated changes or new tools/config unless requested.
- Validate changed areas specifically; avoid repo‑wide churn.
- When in doubt, propose options and ask before proceeding.

## Optional Preferences (edit as desired)
- Auto‑create a plan for any task touching >1 file: true
- Auto‑run formatters before commit: true
- Default branch naming for new branches: `chore/<short-topic>`
- Run HM/NixOS builds automatically after config changes: false (ask first)
- Default commit scope for HM changes: `hm:`
- Default commit scope for NixOS changes by host: `nixos(<host>):`

