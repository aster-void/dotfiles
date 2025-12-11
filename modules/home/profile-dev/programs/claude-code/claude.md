language = Japanese
charcode = UTF-8

[workflow]
タスク実行フロー
1. タスク受領
2. KERNEL構造化 ([prompt-preprocess]) - Task/Constraints/Verify 明確化
3. タスク分割 - 小さい複数ゴールに分割
4. エージェント委譲 ([agents]) - KERNEL 記述法でプロンプト作成、委譲
5. ユーザー報告

[kernel-prompt]
KERNEL 記述法

自身のタスク実行時、およびサブエージェントへのプロンプト作成時に適用する:
1. KERNEL変換: 指示を Context/Task/Constraints/Format/Verify の構造に再解釈
   - Task: 単一の明確なゴール（**K**eep it simple, **N**arrow scope）
   - Constraints: 制約・禁止事項（**E**xplicit constraints）
   - Format: 期待される出力形式（**L**ogical structure）
   - Verify: 検証可能な成功基準（**E**asy to verify, **R**eproducible）
2. 分割判定: 複数ゴールを含む場合、単一ゴールのサブタスクに分割
3. サブエージェント: プロンプトに Task/Constraints/Verify を明記（曖昧さ排除）

[agents]
サブエージェント運用
原則 = 調査・実行は常にエージェントに委譲する (メインコンテキスト節約)

同期/非同期の判断:
  デフォルト = 非同期 (run_in_background=true)
  同期にする条件 (いずれかを満たす場合のみ):
    - 結果が後続タスクの入力になる (例: 設計調査→実装)
    - 結果がタスクツリー全体の方針を変える (例: 実現可能性調査)

並列実行の可否:
  - 同一機能を触る複数エージェント → 順番に実行
  - 独立機能なら並列 OK

git worktree (非同期):
  - 検証が全体整合性を要求（build, lint 等）→ gtr で別 worktree → 作業完了後にマージ 削除
  - 参照: git-gtr skill

DO:
  - 「確認不要で実行」を明記
  - 独立タスクは並列起動（1メッセージで複数 Task）
  - ファイル読み取り・調査はエージェントに任せる
  - 非同期完了待ちは block=true でまとめる
DON'T:
  - 自分でファイルを読んでからエージェント起動
  - 曖昧な指示（「問題があれば聞いて」→ 確認待ち）
注意:
  - 複数エージェント → TodoWrite で追跡

[skills.git_commit]
コミットメッセージは基本的に以下のフォーマットとする:
`{scope}: {message}`
scope: コミットの影響のある範囲。 `packages/{package}`, `modules/{module}`, `treewide`, `meta` など
message: コミットの簡潔で明確な説明

[tools]
kiri = MCP server for Git semantic search
pipe = ALWAYS `set -o pipefail` before pipes (例: `set -o pipefail && cat /foo.json | jq .package.version`)
BashOutput = 連続3回以上呼び出し禁止。長時間実行中のコマンドは放置かユーザー確認
git = git stash 絶対禁止

[preferences]
- 失敗するときは明示的に失敗する。暗黙の失敗=エラーの握りつぶしは決して許さない。
  - `rm some-file.txt` > `rm some-file.txt || true`
  - `pkgs.hello` > `if pkgs ? hello then pkgs.hello else null`
- ファイルが大きくなった場合複数に分割する。目安100行。具体的な裁量は自身で判断する。

[tips]
- カレントディレクトリを変更しない。 (NO `cd`)
- CWD を手動で指定しない。常にリポジトリルートにいるので、フルパスではなく `.` を使う
