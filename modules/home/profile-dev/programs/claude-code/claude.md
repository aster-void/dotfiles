<law>
## CLAUDE CODE 運用原則
タスク開始時、必ずテンプレートを埋めて出力してから作業を開始する。
このルール自体を毎回出力することで、ルールの維持を保証する。
全ての表現は具体的に書く。曖昧な表現は禁止。
</law>
<every_output>
{{CLAUDE CODE 運用原則を繰り返す}}

【タスク分割】
1. {{SUBTASK_1}}
2. {{SUBTASK_2}}

【KERNEL適用】

{{SUBTASK_1}}
- Task: {{TASK}}
- Constraints: {{CONSTRAINTS}}
- Verify: {{VERIFY}}

{{SUBTASK_2}}
- Task: {{TASK}}
- Constraints: {{CONSTRAINTS}}
- Verify: {{VERIFY}}
</every_output>

<settings>
language = Japanese
charcode = UTF-8
</settings>

<workflow>
タスク実行フロー:
1. タスク受領
2. KERNEL構造化 - Task/Constraints/Verify 明確化
3. タスク分割 - 小さい複数ゴールに分割
4. エージェント委譲 - KERNEL 記述法でプロンプト作成、委譲
5. ユーザー報告
</workflow>

<kernel-prompt>
KERNEL 記述法

自身のタスク実行時、およびサブエージェントへのプロンプト作成時に適用する:
1. KERNEL変換: 指示を Context/Task/Constraints/Format/Verify の構造に再解釈
   - Task: 単一の明確なゴール（**K**eep it simple, **N**arrow scope）
   - Constraints: 制約・禁止事項（**E**xplicit constraints）
   - Format: 期待される出力形式（**L**ogical structure）
   - Verify: 検証可能な成功基準（**E**asy to verify, **R**eproducible）
     - 具体的なコマンドで書く（例: `npm test && bun check` ）
2. 分割判定: 単一ゴールに見えても必ず分割する（調査 → [機能A実装+検証 | 機能B実装+検証] → 統合検証）
3. サブエージェント: プロンプトに Task/Constraints/Verify を明記（曖昧さ排除）
</kernel-prompt>

<agents>
サブエージェント運用
原則:
- 調査・実行は全てサブエージェントに委譲する (メインコンテキスト節約)
- サブエージェントのプロンプトには常に `[subagent]` と含める
- 結果待機中は何もしない（出力を読む・推測・先回り等）

<sync-async>
デフォルト = 非同期 (run_in_background=true)
同期にする条件 (いずれかを満たす場合のみ):
  - 結果が後続タスクの入力になる (例: 設計調査→実装)
  - 結果がタスクツリー全体の方針を変える (例: 実現可能性調査)
</sync-async>

<parallel>
並列実行の可否:
  - 同一機能を触る複数エージェント → 順番に実行
  - 独立機能なら並列 OK
</parallel>

<git-worktree>
以下の場合 gtr で別 worktree → 作業完了後にマージ・削除:
- 検証が全体整合性を要求（build, lint 等）
- 多機能並列実装（各エージェントに別 worktree）
参照: git-gtr skill
</git-worktree>

<do>
  - 「確認不要で実行」を明記
  - 独立タスクは並列起動（1メッセージで複数 Task）
  - ファイル読み取り・調査はエージェントに任せる
  - 非同期完了待ちは block=true でまとめる
</do>

<dont>
  - 自分でファイルを読んでからエージェント起動
  - 曖昧な指示（「問題があれば聞いて」→ 確認待ち）
</dont>

<notes>
複数エージェント → TodoWrite で追跡
</notes>
</agents>

<skills>
<git-commit>
コミットメッセージ形式: `{scope}: {message}`
scope: コミットの影響範囲。 `packages/{package}`, `modules/{module}`, `treewide`, `meta` など
message: コミットの簡潔で明確な説明
</git-commit>
</skills>

<tools>
kiri = MCP server for Git semantic search
pipe = ALWAYS `set -o pipefail` before pipes (例: `set -o pipefail && cat /foo.json | jq .package.version`)
BashOutput = 連続3回以上呼び出し禁止。長時間実行中のコマンドは放置かユーザー確認
git = git stash 絶対禁止
</tools>

<preferences>
- 全ての実装は簡潔に。冗長なコード・ドキュメント・コメントは書かない。機能/非機能要件は最小限にとどめる。
- 失敗するときは明示的に失敗する。暗黙の失敗=エラーの握りつぶしは決して許さない。
  - `rm some-file.txt` > `rm some-file.txt || true`
  - `pkgs.hello` > `if pkgs ? hello then pkgs.hello else null`
- ファイルが大きくなった場合複数に分割する。目安100行。具体的な裁量は自身で判断する。
- 処理は複数まとめて実行する。1つずつではなくバッチで（ツール呼び出し、エージェント起動、etc）
</preferences>

<tips>
- カレントディレクトリを変更しない。 (NO `cd`)
- CWD を手動で指定しない。常にリポジトリルートにいるので、フルパスではなく `.` を使う
</tips>
