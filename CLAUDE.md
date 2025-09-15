# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview
Personal dotfiles repository with Nix/NixOS configurations and application dotfiles. Uses Nix flakes for declarative system and home management.

## Essential Commands

### NixOS System Management
```bash
# Build system configuration (test without switching)
nixos-rebuild build --flake .

# Switch to new system configuration  
sudo nixos-rebuild switch --flake .#<hostname>

# Available hosts: amberwood, bogster, carbon, dusk
```

### Home Manager
```bash
# Switch home configuration
nix run github:nix-community/home-manager -- switch --flake .#<hostname>

# Example for amberwood host
nix run github:nix-community/home-manager -- switch --flake .#amberwood
```

### Development and Linting
```bash
# Format all Nix files (via lefthook pre-commit)
alejandra *.nix

# Check for dead code
deadnix --fail .

# Static analysis  
statix check .

# All linting runs automatically on git commit via lefthook
```

## Architecture Overview

### Nix Configuration Structure
- **Entry Point**: `flake.nix` - Central configuration using Nix flakes
- **Metadata**: `meta.nix` - User-specific settings (username, email, system architecture)
- **Shared Configuration**: `shared/` - Reusable modules (shell aliases, git config)

### NixOS 4-Layer Architecture
```
nixos/
├── core/           # System-wide base configuration
│   ├── boot/       # Boot settings (mostly host-specific)
│   ├── system/     # Kernel, hardware abstraction
│   ├── users/      # User account management  
│   ├── network/    # Network configuration
│   ├── i18n/       # Internationalization
│   └── hardware/   # Hardware-specific settings
├── profiles/       # Use-case specific configurations
│   ├── base/       # Essential packages and shell setup
│   ├── development/# Development tools and LSPs
│   └── gaming/     # Gaming-related packages
├── desktop/        # Desktop environment configurations  
│   ├── environments/# Window managers (Hyprland, GNOME, etc.)
│   ├── packages.nix# Desktop application packages
│   └── flatpak.nix # Flatpak configuration
└── hosts/          # Host-specific configurations
    ├── amberwood/  # Gaming desktop with NVIDIA
    ├── bogster/    # Intel laptop  
    ├── carbon/     # Server configuration
    └── dusk/       # Another desktop variant
```

### Key Design Principles
- **Modularity**: Each layer imports what it needs, hosts import `../../desktop`, `../../profiles`, etc.
- **Inlined Packages**: Package definitions are embedded directly in profiles rather than separate files
- **Centralized Desktop**: All desktop components imported via `desktop/default.nix`
- **Host Specialization**: Host-specific hardware, bootloader, and driver configurations

### Home Manager Structure  
```
home-manager/
├── profiles/       # User environment profiles per host
├── features/       # Reusable home configuration modules
└── store/          # Application-specific configurations
```

### Development Workflow
- Configurations are built and tested before switching
- Git hooks automatically format and lint Nix code via lefthook
- Personal settings in `meta.nix` should be updated when adapting for other users

## Global Development Guidelines

### Workflow Instructions
- 機能実装をする前に仕様を整理して、ユーザーに確認を取って。
- 作業が完了したらコミットして。
- コミットする前に必ず動作を確認して。
    - nixos の場合は `nixos-rebuild build --flake .`
    - home manager の場合は `home-manager build --flake .`

### Development Best Practices  
- すべての機能の実装前後に、考えうる懸念点を洗い出して。 (セキュリティ面・パフォーマンス面など)
- 実行ファイルへのパスをハードコードしないで。
    - BAD: `/usr/bin/waybar`
    - GOOD 下記のいずれか:
        - `${pkgs.waybar}/bin/waybar`
        - `${lib.getExe pkgs.waybar}`
