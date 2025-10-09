# NixOS README

Warning

- This repo is tailored for my hosts and preferences. Treat as reference unless you know what you’re doing.
- It may contain breaking changes at any time. If you fork it, detach from my remote.

How To Build

- Enter dev shell: `direnv allow` or `nix develop`
- NixOS build (don’t switch unless you intend to apply):
  - `nixos-rebuild build --flake .#<host>`
- NixOS switch (apply after successful build):
  - `sudo nixos-rebuild switch --flake .#<host>`

Home Manager

- Build: `home-manager build --flake .#<user@host>`
- Apply: `home-manager switch --flake .#<user@host>`

Hosts

- See `nixos/hosts/<name>/` for host-specific modules. Top-level entry: `nixos/default.nix`.

Secure Boot

- Read: https://nixos.wiki/wiki/Secure_Boot

After Install (optional)

- `lefthook install` to enable formatting/lint hooks.
