# Fish Functions

## User Commands

| Command | Description |
|---------|-------------|
| `mkcd <dir>` | ディレクトリを作成して移動 |
| `pc` | ghqリポジトリをpecoで選択して移動 |
| `ph` | コマンド履歴をpecoで検索・実行 |
| `peco_kill` | プロセスをpecoで選択してkill |
| `repo g <url>` | GitHubリポジトリをclone (ghq代替) |
| `yz` | yaziを起動、終了時にそのディレクトリへ移動 |

## Usage

### mkcd
```bash
mkcd my-project/src  # ディレクトリ作成 & 移動
```

### pc (peco_cd)
```bash
pc  # ghq管理のリポジトリ一覧から選択して移動
```

### ph (peco_select_history)
```bash
ph        # 履歴を検索
ph docker # "docker"で絞り込んで検索
```

### peco_kill
```bash
peco_kill  # プロセス一覧から選択してkill
```

### repo
```bash
repo g https://github.com/org/repo      # ~/ghq/github.com/org/repo にclone
repo g https://github.com/org/repo.git  # .git付きでもOK
```

### yz
```bash
yz      # yaziを起動、qで終了時にそのディレクトリへcd
yz /tmp # 指定ディレクトリでyaziを起動
```

## Internal Functions

- `__z*` - z (autojump) plugin
- `fish_*` - fish shell prompt/title設定
- `fisher` - fisherプラグインマネージャ
