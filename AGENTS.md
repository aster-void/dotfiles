# Repository Guidelines

## Project Structure & Modules
- Root entrypoint: `flake.nix` (defines dev shell, `homeConfigurations`, `nixosConfigurations`).
- Home Manager: `home-manager/` with `profiles/` (host/grouped setups), `features/` (reusable modules), `store/` (app configs).
- NixOS: `nixos/` with `hosts/<name>/`, `core/`, and `profiles/` (see `nixos/default.nix`).
- Dotfiles to stow: `stow/` (e.g., `stow/.config/...`).
- Shared reusable bits: `shared/`. Local packages: `my/pkgs/`.
- Secrets policy: `secrets/` managed via agenix; keys from `meta.nix`.

## Build, Test, Develop
- Enter dev shell: `direnv allow` (uses `.envrc`) or `nix develop`.
- NixOS (do not switch unless requested):
  - Build: `nixos-rebuild build --flake .#<host>`
  - Apply: `sudo nixos-rebuild switch --flake .#<host>`
- Home Manager:
  - Build: `home-manager build --flake .#<user@host>`
  - Apply: `home-manager switch --flake .#<user@host>`
  - If HM is not installed: `nix run github:nix-community/home-manager -- switch --flake .#amberwood`
- Lint/format (also run via `lefthook` on commit):
  - `alejandra *.nix`
  - `deadnix --fail .`
  - `statix check .`

## Coding Style & Naming
- Nix formatting is authoritative via `alejandra` (no manual alignment); 2‑space indent, trailing commas where idiomatic.
- Filenames: kebab-case (`packages.nix`, `hardware-configuration.nix`).
- Modules are small and composable; put host specifics under `nixos/hosts/<host>/` or `home-manager/profiles/`.
- Do not hardcode binary paths; prefer `${lib.getExe pkgs.<pkg>}` or `${pkgs.<pkg>}/bin/<exe>`.

## Testing Guidelines
- Treat builds as tests:
  - NixOS: `nixos-rebuild build --flake .#<host>`
  - Home Manager: `home-manager build --flake .#<user@host>`
- Switch only after a successful build. No unit tests/coverage targets for this repo.

## Commit & Pull Requests
- Prefer Conventional Commits (`feat:`, `fix:`, `chore:`). Common prefixes in this repo include `hm:`, `nixos:`, and scoped fixes (`fix(amberwood):`).
- PRs should include: summary, affected hosts/profiles, before/after notes, and screenshots for desktop changes.
- Keep changes scoped and modular; update comments where behavior is non-obvious.

## Security & Configuration Tips
- Never commit raw secrets; add `.age` files under `secrets/` and register in `secrets/secrets.nix` with keys from `meta.nix`.
- Validate with `deadnix`/`statix`; avoid unused or dangling options.
