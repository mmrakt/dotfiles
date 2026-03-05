---
name: codebase-onboarding
description: "コードベースを探索して技術詳細・スタック・設計・機能などを網羅的にまとめたオンボーディング資料を生成する。Use when: 新規参加メンバー向け技術ドキュメント作成、プロジェクトの技術スタック整理、アーキテクチャ概要の文書化、既存コードベースの調査・把握。Trigger keywords: オンボーディング, onboarding, 技術詳細, 技術スタック, tech stack, 設計, アーキテクチャ, architecture, コードベース探索, 概要資料, 技術資料, プロジェクト概要, codebase overview, getting started, 仕様まとめ"
---

# Codebase Onboarding

任意のリポジトリを探索し、開発者が即戦力になれるオンボーディング資料を生成する。

## ワークフロー

### Step 1 — スコープ確認

ユーザーに以下を確認する（すでに情報があればスキップ）：

- 対象リポジトリ（カレントワークスペースか、別パスか）
- 出力言語（デフォルト: 日本語）
- 深さ（Quick / Standard / Deep）
  - **Quick**: 目次＋技術スタック＋エントリポイントのみ（〜10分）
  - **Standard**: 全セクション、コード例なし（〜20分）
  - **Deep**: 全セクション＋コード例＋設計判断の考察（〜40分）

### Step 2 — コードベース探索

以下を並行して実行する：

1. **プロジェクト種別の特定** — `references/exploration-guide.md` を読み、種別に応じた探索チェックリストを選択する
2. **トップレベル構造のスキャン** — ディレクトリツリー（深さ2〜3）を取得
3. **設定ファイルの収集** — `package.json`, `pyproject.toml`, `Cargo.toml`, `go.mod`, `build.gradle`, `Dockerfile`, `docker-compose.yml` など
4. **エントリポイントの特定** — `main.*`, `index.*`, `app.*`, `cmd/` など
5. **主要モジュールの把握** — src/, lib/, packages/ 以下のトップレベル構造

> 探索は読み取り専用。ファイルを編集・削除しない。

### Step 3 — 資料生成

`assets/onboarding-template.md` をベースに、探索結果を埋めてオンボーディング資料を生成する。

- 出力ファイルパス: `docs/onboarding.md`（ユーザー指定があれば優先）
- テンプレートのセクションのうち、情報が見つからないものは「情報なし」と記載せず、セクションを省略する
- Quick の場合は `## 技術スタック` と `## はじめ方` と `## エントリポイント` のみ出力

### Step 4 — レビュー提示

生成した資料の概要をユーザーに提示し、追記・修正リクエストに対応する。

## Resources

- **探索チェックリスト（プロジェクト種別別）**: [references/exploration-guide.md](references/exploration-guide.md)
- **出力テンプレート**: [assets/onboarding-template.md](assets/onboarding-template.md)

### scripts/
Executable code (Python/Bash/etc.) that can be run directly to perform specific operations.

**Examples from other skills:**
- PDF skill: `fill_fillable_fields.py`, `extract_form_field_info.py` - utilities for PDF manipulation
- DOCX skill: `document.py`, `utilities.py` - Python modules for document processing

**Appropriate for:** Python scripts, shell scripts, or any executable code that performs automation, data processing, or specific operations.

**Note:** Scripts may be executed without loading into context, but can still be read by Codex for patching or environment adjustments.

### references/
Documentation and reference material intended to be loaded into context to inform Codex's process and thinking.

**Examples from other skills:**
- Product management: `communication.md`, `context_building.md` - detailed workflow guides
- BigQuery: API reference documentation and query examples
- Finance: Schema documentation, company policies

**Appropriate for:** In-depth documentation, API references, database schemas, comprehensive guides, or any detailed information that Codex should reference while working.

### assets/
Files not intended to be loaded into context, but rather used within the output Codex produces.

**Examples from other skills:**
- Brand styling: PowerPoint template files (.pptx), logo files
- Frontend builder: HTML/React boilerplate project directories
- Typography: Font files (.ttf, .woff2)

**Appropriate for:** Templates, boilerplate code, document templates, images, icons, fonts, or any files meant to be copied or used in the final output.

---

**Not every skill requires all three types of resources.**
