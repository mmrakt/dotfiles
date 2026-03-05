# コードベース探索ガイド

プロジェクト種別ごとの探索チェックリストと、見つけた情報をオンボーディング資料の各セクションへマッピングする手順。

## 目次

1. [プロジェクト種別の判定](#プロジェクト種別の判定)
2. [共通チェックリスト](#共通チェックリスト)
3. [種別別チェックリスト](#種別別チェックリスト)
4. [セクションマッピング](#セクションマッピング)

---

## プロジェクト種別の判定

以下のファイル有無で種別を特定する（複数該当する場合はすべて記録）。

| ファイル・パターン | プロジェクト種別 |
|---|---|
| `package.json` + `src/` + `components/` | フロントエンド（React/Vue/etc） |
| `package.json` + `server.js` / `app.js` / `src/index.ts` + express/fastify | Node.js バックエンド |
| `pyproject.toml` / `setup.py` + `src/` | Python パッケージ / ライブラリ |
| `pyproject.toml` / `requirements.txt` + `app.py` / `main.py` + FastAPI/Flask/Django | Python Web アプリ |
| `go.mod` | Go アプリ / ライブラリ |
| `Cargo.toml` | Rust |
| `build.gradle` / `pom.xml` | Java / Kotlin |
| `*.csproj` / `*.sln` | .NET |
| `Dockerfile` + `docker-compose.yml` | コンテナ化アプリ（種別は別途判定） |
| `notebooks/` / `*.ipynb` + `requirements.txt` | データサイエンス / ML |
| `.github/workflows/` のみ | CI/CD 設定リポジトリ |
| `terraform/` / `*.tf` | インフラ as Code |
| `charts/` / `helm/` | Kubernetes / Helm |

---

## 共通チェックリスト

どのプロジェクト種別でも実施する。

### 必須確認ファイル

- [ ] `README.md` — プロジェクト説明、セットアップ手順
- [ ] `LICENSE` — ライセンス種別
- [ ] `.gitignore` — 無視されているファイルから技術スタックを推測
- [ ] `CONTRIBUTING.md` — コントリビューションガイド（あれば）
- [ ] `CHANGELOG.md` / `HISTORY.md` — 変更履歴（あれば）

### 依存関係ファイル

| ファイル | 確認内容 |
|---|---|
| `package.json` | dependencies, devDependencies, scripts |
| `pyproject.toml` / `requirements*.txt` | dependencies, tool 設定 |
| `go.mod` | module 名, require |
| `Cargo.toml` | dependencies, workspace |
| `Gemfile` | gem 一覧 |
| `build.gradle` / `pom.xml` | dependencies |
| `*.lock` ファイル | バージョン固定状況（読まなくてよい） |

### 設定ファイル

- [ ] `Dockerfile` / `docker-compose.yml` — コンテナ構成、ポート、サービス一覧
- [ ] `.env.example` / `.env.sample` / `config/` — 環境変数一覧
- [ ] CI設定（`.github/workflows/`, `.gitlab-ci.yml`, `Jenkinsfile`, `circle.yml`）— パイプライン構成
- [ ] `Makefile` / `Taskfile.yml` — よく使うコマンド

---

## 種別別チェックリスト

### フロントエンド（React / Vue / Angular / Svelte）

- [ ] フレームワーク： `package.json` の `dependencies` でフレームワークを特定
- [ ] ビルドツール： `vite.config.*`, `webpack.config.*`, `next.config.*`
- [ ] ルーティング方式： `src/routes/`, `src/pages/`, `app/` (Next.js App Router)
- [ ] 状態管理： Redux, Zustand, Pinia, Vuex, Context API
- [ ] スタイリング： Tailwind, CSS Modules, styled-components, Sass
- [ ] コンポーネント構成： `src/components/` のトップレベルを確認
- [ ] API呼び出し： `src/api/`, `src/services/`, `src/lib/` を確認
- [ ] 環境変数: `.env.example`, `NEXT_PUBLIC_*`, `VITE_*` プレフィックス

### Node.js バックエンド

- [ ] フレームワーク特定： Express, Fastify, Koa, NestJS, Hono
- [ ] エントリポイント： `src/index.ts`, `server.ts`, `app.ts`
- [ ] ルーティング構成： `src/routes/`, `src/controllers/`
- [ ] ミドルウェア一覧： `src/middleware/`
- [ ] DB アクセス層： ORM (Prisma, TypeORM, Sequelize) の schema/migration を確認
- [ ] 認証方式： passport, JWT, session
- [ ] 設定管理： `src/config/`, `dotenv`

### Python Web アプリ（FastAPI / Flask / Django）

- [ ] フレームワーク特定
- [ ] エントリポイント： `main.py`, `app.py`, `manage.py`
- [ ] ルーティング： `routers/`, `views/`, `urls.py`
- [ ] モデル層： `models/`, `schemas/` (Pydantic)
- [ ] DB migration： `alembic/`, `migrations/`
- [ ] 依存関係注入 / DI パターン
- [ ] `requirements.txt` / `pyproject.toml` でバージョン確認

### Python パッケージ / ライブラリ

- [ ] パッケージ名・バージョン： `pyproject.toml` の `[project]`
- [ ] 公開 API: `src/{package}/__init__.py` のエクスポート
- [ ] モジュール構造: `src/` 以下のディレクトリ
- [ ] テスト構成: `tests/`, `pytest.ini`
- [ ] ビルド設定: `[build-system]` in `pyproject.toml`

### Go アプリ

- [ ] モジュール名・バージョン: `go.mod`
- [ ] `cmd/` 配下のエントリポイント
- [ ] `internal/` vs `pkg/` の使い分け
- [ ] 主要パッケージ構成
- [ ] 依存フレームワーク: gin, echo, fiber, chi など

### データサイエンス / ML

- [ ] Notebook 一覧と処理の流れ
- [ ] データ取得・前処理パイプライン
- [ ] モデル学習・評価の手順
- [ ] 主要ライブラリ: scikit-learn, pandas, PyTorch, TensorFlow, etc.
- [ ] 実験管理ツール: MLflow, W&B, DVC
- [ ] データディレクトリ構成: `data/raw`, `data/processed`, `models/`

### インフラ as Code（Terraform / Pulumi / CDK）

- [ ] プロバイダー: AWS, GCP, Azure, etc.
- [ ] リソースの全体像: `main.tf` or `__main__.py`
- [ ] モジュール構成: `modules/`
- [ ] 変数定義: `variables.tf`, `vars/`
- [ ] state 管理方式: remote backend 設定

---

## セクションマッピング

探索で得た情報をオンボーディング資料のどのセクションに書くかの対応表。

| 探索で見つけた情報 | 資料のセクション |
|---|---|
| README のプロジェクト説明 | プロジェクト概要 |
| `package.json` / `pyproject.toml` の依存関係 | 技術スタック |
| `Dockerfile`, インフラ設定 | 技術スタック > インフラ |
| ディレクトリツリー（深さ2） | ディレクトリ構成 |
| `src/`, `lib/`, `packages/` の構成 | 主要モジュール・コンポーネント |
| `README` のセットアップ手順 / `Makefile` | はじめ方 |
| `main.*`, `index.*`, `cmd/` | エントリポイント |
| ORM スキーマ, `migrations/`, DB 設定 | データモデル・スキーマ |
| `.env.example`, 外部サービス呼び出し | 外部依存・連携サービス |
| `tests/`, `*.test.*`, `pytest.ini` | テスト |
| `.github/workflows/`, CI設定 | CI/CD・デプロイ |
| コメント内の設計判断・ADR | 設計上の特記事項 |
| `Makefile`, `package.json scripts`, よく使うコマンド | よくある作業パターン |
