#!/usr/bin/env fish

set dotfiles $HOME/ghq/github.com/mmrakt/dotfiles
set backup_dir $HOME/.dotfiles_backup/(date +%Y%m%d_%H%M%S)

function link_file
    set src $argv[1]
    set dest $argv[2]

    # 親ディレクトリ作成
    mkdir -p (dirname $dest)

    # 既存ファイルのバックアップ
    if test -e $dest -a ! -L $dest
        mkdir -p $backup_dir
        set backup_path $backup_dir/(basename $dest)
        mv $dest $backup_path
        echo "📦 Backed up: $dest → $backup_path"
    end

    # 既存シンボリックリンク削除
    if test -L $dest
        rm $dest
    end

    # シンボリックリンク作成
    ln -s $src $dest
    echo "🔗 Linked: $dest → $src"
end

function link_dir
    set src $argv[1]
    set dest $argv[2]

    for file in $src/*
        if test -f $file
            set relative (string replace $src "" $file)
            link_file $file $dest$relative
        else if test -d $file
            link_dir $file $dest/(basename $file)
        end
    end
end

echo "🔧 Creating symlinks..."

# .config ディレクトリ
for dir in fish gh karabiner raycast zed github-copilot
    if test -d $dotfiles/.config/$dir
        link_dir $dotfiles/.config/$dir $HOME/.config/$dir
    end
end

# .cursor
if test -d $dotfiles/.cursor
    link_dir $dotfiles/.cursor $HOME/.cursor
end

# .claude
if test -d $dotfiles/.claude
    link_file $dotfiles/.claude/settings.json $HOME/.claude/settings.json
end

# .warp
if test -d $dotfiles/.warp
    link_file $dotfiles/.warp/keybindings.yaml $HOME/.warp/keybindings.yaml
end

# VSCode (macOS)
set vscode_dir "$HOME/Library/Application Support/Code/User"
if test -d $dotfiles/.vscode
    link_file $dotfiles/.vscode/settings.json "$vscode_dir/settings.json"
    link_file $dotfiles/.vscode/keybindings.json "$vscode_dir/keybindings.json"
end

echo ""
echo "✅ Done!"
if test -d $backup_dir
    echo "📦 Backups saved to: $backup_dir"
end
