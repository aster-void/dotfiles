---
name: claude-config
description: Guide for writing CLAUDE.md files and Claude Code skills. Use when the user asks about configuring Claude Code project instructions or creating skills.
user-invocable: true
argument-hint: [topic]
---

# CLAUDE.md 作成ガイド

Claude のオンボーディング資料。何も知らない状態から作業を開始できる最低限のプロジェクト固有情報を書く。

## 原則

コンテキストウィンドウは有限。書かなくて済むなら書くな。

## ルール

- 目標50行以内、最大100行
- 必要な範囲が狭いものは遅延読み込みする（skill、ファイル内コメント等）
- 書くもの:
  - コマンド（ビルド、テスト、デプロイ等）
  - 罠になるお作法（普通と違う規約、ハマりポイント）
  - verification（動作確認コマンド等）

## Verification

- 100行以内である
- これ以上削れる情報がない

$ARGUMENTS
