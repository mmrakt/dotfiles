set -l config_dir (dirname (status --current-filename))
test -f $config_dir/secrets.fish; and source $config_dir/secrets.fish

# export
export LSCOLORS=gxfxcxdxbxegedabagacad

if status is-interactive
    # Commands to run in interactive sessions can go here
    # oh-my-posh theme
    # ref. https://ohmyposh.dev/docs/installation/customize
    if type -q oh-my-posh
        oh-my-posh init fish --config "$HOME/ghq/github.com/mmrakt/dotfiles/.config/fish/themes/the-unnamed.omp.json" | source
    end

    test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish

    # activate mise
    test -x ~/.local/bin/mise; and ~/.local/bin/mise activate fish | source
end

# Added by Antigravity
test -d $HOME/.antigravity/antigravity/bin; and fish_add_path $HOME/.antigravity/antigravity/bin

set PATH $HOME/ghq/github.com/mmrakt/dotfiles/.bin $PATH
