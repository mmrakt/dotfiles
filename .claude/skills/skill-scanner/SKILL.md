---
name: skill-scanner
description: このスキルは「スキルをチェックして」「skill scanner を実行して」「スキルをスキャンして」「スキルのセキュリティ確認して」「SKILL.md を検証して」「スキルのバリデーション」のようなリクエストに使用する。グローバル (~/.claude/skills/) またはプロジェクトローカル (.claude/skills/) のスキルを `skill-scanner` CLI でスキャンし、セキュリティ上の問題や品質リスクを報告する。実行スコープの指定がない場合は必ずユーザーに確認してから処理を開始する。
version: 0.1.0
---

# スキルスキャナー

`skill-scanner` CLI を使って Claude Code スキルのセキュリティ・品質問題を検出し、結果を報告する。

## 重要: 実行スコープの確認

**グローバル / プロジェクトローカルの指定がない場合は必ずユーザーに確認する。**

```
スキルスキャンを実行します。どちらを対象にしますか？

1. グローバル — ~/.claude/skills/ 以下のすべてのスキル
2. プロジェクトローカル — 現在のプロジェクトの .claude/skills/

（特定のスキル名のみを指定することも可能です）
```

スコープが確定してから次のステップに進む。

## コマンドリファレンス

### 基本スキャン

```bash
# 単一スキルをスキャン
skill-scanner scan /path/to/skill

# 複数スキルをまとめてスキャン
skill-scanner scan-all /path/to/skills/

# 再帰的に検索
skill-scanner scan-all /path/to/skills/ --recursive
```

### スコープ別コマンド

**グローバル（全スキル）:**
```bash
skill-scanner scan-all ~/.claude/skills
```

**グローバル（特定スキル）:**
```bash
skill-scanner scan ~/.claude/skills/<skill-name>
```

**プロジェクトローカル（全スキル）:**
```bash
skill-scanner scan-all .claude/skills
```

**プロジェクトローカル（特定スキル）:**
```bash
skill-scanner scan .claude/skills/<skill-name>
```

### 出力フォーマット

```bash
# デフォルト（summary）
skill-scanner scan-all ~/.claude/skills

# Markdown レポート
skill-scanner scan-all ~/.claude/skills --format markdown

# 詳細な Markdown レポート（findings の詳細含む）
skill-scanner scan-all ~/.claude/skills --format markdown --detailed

# テーブル形式
skill-scanner scan-all ~/.claude/skills --format table

# JSON（プログラム処理向け）
skill-scanner scan-all ~/.claude/skills --format json

# ファイルに保存
skill-scanner scan-all ~/.claude/skills --format markdown -o report.md
```

### 高度なオプション

```bash
# CI/CD 用: 問題があれば非ゼロ終了
skill-scanner scan-all ~/.claude/skills --fail-on-severity medium

# セキュリティポリシーを指定（strict / balanced / permissive）
skill-scanner scan ~/.claude/skills/<skill-name> --policy strict

# LLM ベースのセマンティック解析（要 API キー）
skill-scanner scan ~/.claude/skills/<skill-name> --use-llm

# スキル間の description 重複チェック
skill-scanner scan-all ~/.claude/skills --check-overlap

# 利用可能なアナライザー一覧
skill-scanner list-analyzers
```

## ワークフロー

### Step 1 — スコープ確定

ユーザーに確認して以下のコマンドを決定する：

| 対象 | コマンド |
|---|---|
| グローバル・全スキル | `skill-scanner scan-all ~/.claude/skills` |
| グローバル・特定スキル | `skill-scanner scan ~/.claude/skills/<name>` |
| プロジェクトローカル・全スキル | `skill-scanner scan-all .claude/skills` |
| プロジェクトローカル・特定スキル | `skill-scanner scan .claude/skills/<name>` |

### Step 2 — スキャン実行

`--format markdown --detailed` を付けて実行することで見やすいレポートを生成する：

```bash
skill-scanner scan-all ~/.claude/skills --format markdown --detailed
```

### Step 3 — 結果の解釈と修正提案

スキャン結果の重要度を確認して対応を提案する：

| 重要度 | 意味 | 対応 |
|---|---|---|
| CRITICAL | 深刻なセキュリティリスク | 即時修正必須 |
| HIGH | 高リスクの問題 | 早急に修正 |
| MEDIUM | 中程度のリスク | 修正を推奨 |
| LOW | 軽微な問題 | 状況に応じて対応 |
| INFO | 参考情報（ライセンス未設定など） | 任意で対応 |

よくある検出パターンと対処：

| ルール ID | 内容 | 対処 |
|---|---|---|
| `PIPELINE_TAINT_FLOW` | ネットワーク経由のスクリプト実行（`curl ... \| sh`）| 公式インストーラーであれば許容、不明な場合は削除 |
| `MANIFEST_MISSING_LICENSE` | `license` フィールドが未設定 | frontmatter に `license: MIT` 等を追加（任意） |
| `DESCRIPTION_OVERLAP` | 他スキルと description が重複 | トリガーフレーズを具体化・差別化する |
