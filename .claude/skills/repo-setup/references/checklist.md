# 環境構築チェックリスト

スキップしても問題ないステップは `(任意)` と表記する。

## 共通

- [ ] リポジトリの取得（クローン済みの場合はスキップ）
- [ ] 正しいディレクトリに移動
- [ ] README.md を読んで特殊な手順を確認
- [ ] `.mise.toml` / `.tool-versions` が存在すれば `mise install` でランタイムをセットアップ
- [ ] `.env.example` / `.env.sample` が存在するか確認
- [ ] `.env` のコピーと必須変数の設定

## Node.js プロジェクト

- [ ] `.mise.toml` / `.tool-versions` があれば `mise install` でバージョンをセットアップ（推奨）
- [ ] mise が使えない場合: `.nvmrc` / `.node-version` を確認し `fnm use` で切り替え
- [ ] ロックファイルからパッケージマネージャーを特定
- [ ] 依存関係のインストール（`npm install` / `yarn` / `pnpm install` / `bun install`）
- [ ] `setup` / `prepare` スクリプトの実行（任意）
- [ ] 開発サーバーの起動確認（`npm run dev` など）

## Python プロジェクト

- [ ] `.mise.toml` / `.tool-versions` があれば `mise install` でバージョンをセットアップ（推奨）
- [ ] mise が使えない場合: `.python-version` を確認し `pyenv local` で切り替え
- [ ] `uv sync` で依存関係をインストール（推奨）
- [ ] `pyproject.toml` に `[tool.poetry]` 等がある場合は該当ツールで実行
- [ ] 起動スクリプトの確認

## データベースを含むプロジェクト

- [ ] データベースサービスの起動（`docker compose up -d` など）
- [ ] マイグレーションの実行（`npm run db:migrate` / `python manage.py migrate` など）
- [ ] シードデータの投入（任意、`npm run db:seed` など）

## Docker を使うプロジェクト

- [ ] Docker Desktop が起動しているか確認
- [ ] `docker compose up -d` でサービスを起動
- [ ] ログで起動確認（`docker compose logs -f`）

## よく使うコマンド一覧

```bash
# ghq でリポジトリ取得
ghq get https://github.com/<owner>/<repo>
cd (ghq root)/github.com/<owner>/<repo>

# mise でランタイムをセットアップ（推奨）
mise install

# mise が使えない場合のフォールバック
# Node.js: fnm use
# Python: pyenv local

# 環境変数のコピー
cp .env.example .env

# Python 依存インストール（uv）
uv sync
```
