# AGENTS.md

Note: CLAUDE.md is a symlink to this file.

## 概要

NixOS ベースの統合システム構成（サーバー + デスクトップ）。Blueprint フレームワークで管理。

## ディレクトリ構造

- `hosts/{hostname}/` - ホスト固有設定（configuration.nix, services/, users/）
- `modules/nixos/` - NixOS システムモジュール（base/, desktop/, profile-dev/）
- `modules/home/` - home-manager モジュール（desktop/, profile-dev/）
- `packages/` - カスタムパッケージ
- `config/` - 静的設定ファイル（JSON等）
- `secrets/` - agenix 暗号化シークレット

## ルール

**ファイル配置**: 複数ホスト共有 → `modules/`、特定ホスト専用 → `hosts/{hostname}/`

**モジュール構造**
(`modules/{home|nixos}/{module}/`):
- `default.nix` - サブモジュールを imports
- `programs/` - プログラム設定
- `services/` - 外向きサービス
- `system/` - 内向きサービス・ハードウェア
- `extensions/` - `my.{module}.{extension}.enable` で有効化
- `packages.nix` - パッケージインストールのみ

## コミット

形式: `{scope}: {説明}`
scope: `flake` / `hosts/{hostname}` / `modules/{module}` / `packages` / `treewide` / `meta`

## スクリプト

```sh
./scripts/nixos-build.sh [hostname?]  # ビルド確認 (反映はしない)
```

## ツール

```sh
nix-search <query> # パッケージ検索
```

## Tips

- **NixOS システムを直接変更しない**: `~/.claude.json` などを直接編集せず、このリポジトリ内の Nix 設定を変更する。プログラム名でファイル名検索すると見つかる。
