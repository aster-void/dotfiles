# CLAUDE.md - Project Knowledge Base

## Project Structure
This is a dotfiles repository containing configuration files for various applications and tools.

### Key Directories
- `stow/` - Contains all configuration files organized by application
- `home-manager/` - contains home-manager configuration body. the "index" file is `./flake.nix`.
- `nixos/` - contains nixos configuration. the index file is also ./flake.nix

## Global Development Guidelines

### Workflow Instructions
- 機能実装をする前に仕様を整理して、ユーザーに確認を取って。
- 作業が完了し、動作を確認したらコミットして。

### Development Best Practices
- すべての機能の実装前後に、考えうる懸念点を洗い出して。 (セキュリティ面・パフォーマンス面など)
- proactively create documentation files (*.md).

### Documentation Organization
- General project information: This file (CLAUDE.md)
- Feature-specific information: Application directory CLAUDE.md files
- Each application should maintain its own documentation in its respective directory
