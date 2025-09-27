# Global Codex Rules (Unified)

This AGENTS.md supersedes and merges the prior CLAUDE.md. The file `CLAUDE.md` is a symlink to this document.

## Scope & Intent
- Keep changes small, focused, and idiomatic to the repo.
- Prefer surgical edits over refactors unless explicitly requested.
- Never commit raw secrets; use `secrets/` with agenix and keys from `meta.nix`.

## Workflow
- Plan: use the plan tool for multi‑step tasks; skip for trivial ones.
- Build before switching: `nixos-rebuild build --flake .#<host>`, `home-manager build --flake .#<user@host>`.
- Only switch on request: `sudo nixos-rebuild switch --flake .`, `home-manager switch --flake .`.
- Lint/format via lefthook; manual: `alejandra *.nix`, `deadnix --fail .`, `statix check .`.
- Searches: prefer `rg`; when quoting files, read ≤250 lines.
- Dotfiles: use `scripts/stow.sh` to apply stow changes.

## Nix Conventions
- Formatting: `alejandra` is authoritative (2‑space indent, trailing commas where idiomatic).
- Do not hardcode binary paths; prefer `${lib.getExe pkgs.<pkg>}` or `${pkgs.<pkg>}/bin/<exe>`.
- Modules should be small and composable; host specifics live under `nixos/hosts/<host>/` or `home-manager/profiles/`.

## Repository Structure (condensed)
- Entry: `flake.nix` (dev shell, `homeConfigurations`, `nixosConfigurations`).
- Metadata: `meta.nix` (user/system details).
- Shared bits: `shared/`; local packages: `my/pkgs/`.
- NixOS: `nixos/` with `core/`, `profiles/`, optional `desktop/`, and `hosts/<name>/`.
- Home Manager: `home-manager/` with `profiles/`, `features/`, `store/`.
- Dotfiles to stow: `stow/`.

## Design Principles
- Modularity first; layers declare purpose, hosts opt‑in.
- Host specialization for hardware/boot/drivers.

## Agent Behavior
- Be concise and add a short preamble before tool calls.
- Use `apply_patch` for file edits; keep diffs minimal and scoped.
- Validate the changed areas specifically; avoid repo‑wide churn.
- When uncertain, propose options and ask before proceeding.

## Development Guidance
- Clarify specs with the user before implementing; confirm changes after.
- Prefer builds as tests; avoid running `switch` unless asked.
- If something is unfamiliar, research as needed; cite implications when relevant.
- Keep commits conventional: `hm(<feature>): …`, `nixos(<host>|core|profile): …`, `fix(<host>): …`.

## Security
- Add secrets as `.age` files under `secrets/` and register in `secrets/secrets.nix`.
- Validate with `deadnix`/`statix`; avoid unused/dangling options.

## PR Checklist
- Include summary, affected hosts/profiles, before/after notes; add screenshots for desktop changes.

## Preferences
- Auto‑create a plan for tasks touching >1 file.
- Auto‑run formatters before commit.
- Default branch naming: `chore/<short-topic>`.
- Do not auto‑switch after config changes unless asked.
- Default scopes: HM `hm:`, NixOS by host `nixos(<host>):`.
