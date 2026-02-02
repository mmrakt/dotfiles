source (dirname (status --current-filename))/env.fish

# export
export LSCOLORS=gxfxcxdxbxegedabagacad

if status is-interactive
    # Commands to run in interactive sessions can go here
    # oy-my-posh theme
    # ref. https://ohmyposh.dev/docs/installation/customize
    oh-my-posh init fish --config "/Users/$USER_NAME/ghq/github.com/mmrakt/dotfiles/.config/fish/themes/the-unnamed.omp.json" | source
    
    test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
    
    # activate mise
    ~/.local/bin/mise activate fish | source
end

# Added by Antigravity
fish_add_path /Users/akitomimura/.antigravity/antigravity/bin

# MCP tokens
set -gx TANSTACK_MCP_TOKEN "ts_afd499c1f7caf448a9fc2f40d7f42d0d931e4e69c60ee7b55722cef7e9232d10"
set PATH $HOME/ghq/github.com/mmrakt/dotfiles/.bin $PATH
