source (dirname (status --current-filename))/env.fish
test -f (dirname (status --current-filename))/secrets.fish; and source (dirname (status --current-filename))/secrets.fish

# export
export LSCOLORS=gxfxcxdxbxegedabagacad

if status is-interactive
    # Commands to run in interactive sessions can go here
    # oy-my-posh theme
    # ref. https://ohmyposh.dev/docs/installation/customize
    oh-my-posh init fish --config "$HOME/ghq/github.com/mmrakt/dotfiles/.config/fish/themes/the-unnamed.omp.json" | source
    
    test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
    
    # activate mise
    ~/.local/bin/mise activate fish | source
end

# Added by Antigravity
fish_add_path $HOME/.antigravity/antigravity/bin

set PATH $HOME/ghq/github.com/mmrakt/dotfiles/.bin $PATH
