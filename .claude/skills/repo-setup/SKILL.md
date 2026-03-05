---
name: repo-setup
description: このスキルは「リポジトリをセットアップして」「環境構築して」「新しいプロジェクトをクローンして動かしたい」「依存関係をインストールして」「開発環境を整えて」「repo setup」「environment setup」「プロジェクトの初期設定」のようなリクエストに使用する。リポジトリのクローンから依存関係インストール、開発サーバー起動までの環境構築フローを一貫してサポートする。
version: 0.1.0
---

# リポジトリ環境構築スキル

リポジトリのクローンから依存関係のインストール、開発サーバー起動までの一連の環境構築フローを実行する。

## デフォルトツール

プロジェクト内に指定がない限り、以下をデフォルトとして使用する：

| 用途 | ツール |
|---|---|
| ランタイム管理（Node.js / Python / Ruby / Go など） | **mise** |
| Python パッケージ管理 | **uv** |

## ワークフロー

### Step 1 — 情報収集

以下を確認する（すでに情報があればスキップ）：

- 対象リポジトリのURL または ローカルパス
- パッケージマネージャーの希望（未指定ならロックファイルから自動判定）
- 特殊な要件（環境変数、外部サービス連携等）

### Step 2 — リポジトリ取得

**ローカルにない場合：**

```fish
ghq get <repository-url>
# リポジトリパスへ移動
cd (ghq root)/github.com/<owner>/<repo>
```

**すでにローカルにある場合：** 対象ディレクトリへ移動して続行する。

### Step 3 — プロジェクト種別の判定

ルートディレクトリのファイル構成から種別を特定する：

| 判定ファイル | 種別 |
|---|---|
| `package.json` | Node.js / JavaScript / TypeScript |
| `pyproject.toml` / `requirements.txt` | Python |
| `Cargo.toml` | Rust |
| `go.mod` | Go |
| `Gemfile` | Ruby |
| `composer.json` | PHP |
| `build.gradle` / `pom.xml` | Java / Kotlin |

複数の種別が混在する場合は、主要な言語を特定してから依存関係をインストールする。

### Step 4 — ランタイムバージョンの切り替え

`.mise.toml` / `.tool-versions` が存在する場合は mise で一括セットアップする（**推奨**）：

```bash
mise install
```

プロジェクト固有のバージョン管理ファイルが存在しない場合は mise のグローバル設定をそのまま利用するか、ユーザーに確認する。

`mise` が使えない場合のフォールバック：
- Node.js: `fnm use`（`.nvmrc` / `.node-version` が対象）
- Python: `pyenv local`（`.python-version` が対象）

### Step 5 — パッケージマネージャー判定（Node.jsの場合）

ロックファイルで判定する：

```
package-lock.json  → npm
yarn.lock          → yarn
pnpm-lock.yaml     → pnpm
bun.lockb          → bun
```

ロックファイルが複数ある場合や存在しない場合はユーザーに確認する。

`utils/setup-node-repo.sh` が使えるケースでは活用できる（対話式でパッケージマネージャーとリポジトリURLを尋ねる）。

### Step 6 — 依存関係のインストール

#### Node.js

```bash
# npm
npm install

# yarn
yarn install

# pnpm
pnpm install

# bun
bun install
```

#### Python

```bash
# uv（デフォルト・推奨）
uv sync

# pyproject.toml に poetry の設定がある場合
poetry install

# requirements.txt のみの場合（uv を使う）
uv pip install -r requirements.txt
```

> `pyproject.toml` に `[tool.poetry]` や `[tool.pdm]` のような他ツールの設定がある場合はそちらを優先する。それ以外は uv をデフォルトとして使用する。

#### その他

```bash
# Rust
cargo build

# Go
go mod download

# Ruby
bundle install
```

### Step 7 — 環境変数の設定

`.env.example` や `.env.sample` が存在する場合は `.env` にコピーして確認を求める：

```bash
cp .env.example .env
```

必須の環境変数が埋まっていない場合はユーザーに通知する。

### Step 8 — セットアップコマンドの実行

`package.json` に `setup` / `prepare` / `postinstall` スクリプトが存在する場合は実行する。

```bash
npm run setup   # または yarn setup / pnpm setup / bun run setup
```

### Step 9 — 動作確認

一般的なスクリプト名を確認して案内する：

```bash
# 開発サーバー起動
npm run dev / yarn dev / pnpm dev / bun dev

# ビルド
npm run build

# テスト
npm test / npm run test
```

`package.json` の `scripts` フィールドを読んで実際のコマンドを案内する。

## よくある問題と対処

| 問題 | 対処 |
|---|---|
| ランタイムバージョン不一致 | `mise install` を実行。`.mise.toml` / `.tool-versions` がなければ `mise use node@<version>` などで設定 |
| `mise install` でエラー | `mise ls-remote node` などで利用可能バージョンを確認し、指定バージョンを修正 |
| Python パッケージインストール失敗 | `uv` が未インストールの場合は `curl -LsSf https://astral.sh/uv/install.sh \| sh` でインストール |
| ネイティブモジュールのビルドエラー | Xcode Command Line Tools / build-essential のインストールを確認 |
| 権限エラー | `sudo` を避け、mise などのバージョンマネージャー経由でインストール |
| `.env` が未設定 | 必須の環境変数を確認し、ユーザーへ案内 |

## 参考リソース

- **詳細なチェックリスト**: [references/checklist.md](references/checklist.md)
- **setup-node-repo.sh**: `~/ghq/github.com/mmrakt/dotfiles/utils/setup-node-repo.sh`
