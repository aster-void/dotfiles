---
name: skill-creator
description: Claude スキルの作成・レビュー・改善を支援する。Use when user asks to "create a skill", "build a skill", "review a skill", "スキルを作って", "SKILL.md を書いて", or wants help designing workflows for Claude skills.
user-invocable: true
argument-hint: [use-case or path-to-skill]
metadata:
  author: aster-void
  version: 1.0.0
---

# Skill Creator

Claude スキルの作成・レビュー・改善をガイドするスキル。

## スキルとは

フォルダに格納された指示セット。Claude に特定タスクやワークフローの処理方法を教える。

構成:
- `SKILL.md`（必須）: YAML frontmatter + Markdown の指示
- `scripts/`（任意）: 実行可能コード
- `references/`（任意）: 必要時に読み込むドキュメント
- `assets/`（任意）: テンプレート等

## 作成フロー

### Step 1: ユースケース定義

具体的なユースケースを 2-3 個特定する。以下を明確にする:

- ユーザーが達成したいこと
- 必要なマルチステップワークフロー
- 必要なツール（組み込み or MCP）
- 埋め込むべきドメイン知識

ユースケースのカテゴリ:
1. **Document & Asset Creation** — 一貫した高品質な成果物生成（ドキュメント、デザイン、コード等）
2. **Workflow Automation** — 一貫した方法論が有効なマルチステッププロセス
3. **MCP Enhancement** — MCP サーバーのツールアクセスにワークフロー知識を追加

### Step 2: フォルダ作成

```
my-skill-name/          # kebab-case 必須
├── SKILL.md             # 必須（大文字小文字厳密）
├── scripts/             # 任意
├── references/          # 任意
└── assets/              # 任意
```

命名規則:
- フォルダ名: kebab-case（`notion-project-setup`）
- スペース不可、アンダースコア不可、大文字不可
- `README.md` をスキルフォルダ内に置かない

### Step 3: YAML Frontmatter

```yaml
---
name: my-skill-name
description: What it does. Use when user asks to [trigger phrases].
---
```

**必須フィールド:**
- `name`: kebab-case、フォルダ名と一致
- `description`: WHAT（何をするか）+ WHEN（いつ使うか）を必ず含む。1024文字以内

**任意フィールド:**
- `license`: MIT, Apache-2.0 等
- `compatibility`: 環境要件（1-500文字）
- `metadata`: author, version, mcp-server 等のカスタムKV

**禁止事項:**
- XML タグ（`<` `>`）は使用不可（セキュリティ制約）
- name に "claude" や "anthropic" は使用不可（予約語）

### Step 4: description の書き方

構造: `[何をするか] + [いつ使うか] + [主要機能]`

良い例:
```yaml
description: Manages Linear project workflows including sprint planning, task creation, and status tracking. Use when user mentions "sprint", "Linear tasks", "project planning", or asks to "create tickets".
```

悪い例:
```yaml
# 曖昧すぎる
description: Helps with projects.
# トリガーがない
description: Creates sophisticated multi-page documentation systems.
```

### Step 5: 本文（指示）の記述

Frontmatter の後に Markdown で記述。推奨構造:

```markdown
# スキル名

## Instructions

### Step 1: [最初のステップ]
具体的な手順。

### Step 2: [次のステップ]
...

## Examples

### Example 1: [よくあるシナリオ]
User says: "..."
Actions: ...
Result: ...

## Troubleshooting

### Error: [よくあるエラー]
Cause: ...
Solution: ...
```

指示のベストプラクティス:
- 具体的かつ実行可能に書く（「データを検証する」ではなく「`python scripts/validate.py --input {file}` を実行」）
- エラーハンドリングを含める
- バンドルリソースは明示的に参照する
- Progressive Disclosure: 詳細は `references/` に移動し、SKILL.md は核心の指示に集中

## レビューチェックリスト

スキルのレビュー時に確認する項目:

### 構造
- [ ] フォルダ名が kebab-case
- [ ] `SKILL.md` が正確なスペル
- [ ] YAML frontmatter に `---` デリミタ
- [ ] `name` が kebab-case
- [ ] `description` に WHAT と WHEN が含まれる
- [ ] XML タグがない

### 内容
- [ ] 指示が明確で実行可能
- [ ] エラーハンドリングあり
- [ ] 例が提供されている
- [ ] 参照が明示的にリンクされている

### トリガー
- [ ] 明確なタスクでトリガーされる
- [ ] 言い換えでもトリガーされる
- [ ] 無関係なトピックではトリガーされない

## よくある問題と対処

### トリガーされない
- `description` が曖昧すぎる → トリガーフレーズを追加
- 技術用語のキーワードを含める

### トリガーされすぎる
- negative trigger を追加（"Do NOT use for ..."）
- スコープを明確化

### 指示が守られない
- 指示が冗長 → 箇条書きに
- 重要な指示が埋もれている → 先頭に配置、`## Important` ヘッダー使用
- 曖昧な表現 → 具体的なコマンドやチェック項目に

### コンテキスト肥大
- `SKILL.md` は 5,000 語以内に
- 詳細ドキュメントは `references/` に移動

$ARGUMENTS
