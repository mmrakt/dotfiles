# export
export LSCOLORS=gxfxcxdxbxegedabagacad

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# peco
function fish_user_key_bindings
  bind \cr peco_select_history
  bind \cg peco_cd
end

# path
set PATH /opt/homebrew/bin $PATH

# abbr
abbr -a n npm
abbr -a nd "pnpm dev"
abbr -a nb "pnpm build"
abbr -a np "pnpm preview"
abbr -a nr "pnpm revbuild"
abbr -a nt "pnpm test"
abbr -a nl "pnpm lint"
abbr -a nf "pnpm format"
abbr -a nlss "pnpm localstack:start"
abbr -a nlsi "pnpm localstack:import"
abbr -a nlm "pnpm local:msw"
abbr -a nls "pnpm local:local-server"
abbr -a pn pnpm
abbr -a pnd "pnpm dev"
abbr -a pnb "pnpm build"
abbr -a pnp "pnpm preview"
abbr -a y yarn
abbr -a d docker
abbr -a dc docker-compose
abbr -a g git
abbr -a gs "git switch"
abbr -a gc "git switch -c"
abbr -a gf "git fetch"
abbr -a gp "git pull"
abbr -a gb "git branch"
abbr -a gd "git branch -D"
abbr -a gball "git branch | xargs git branch -D"
abbr -a gl "git log --oneline"
abbr -a gst "git stash"
abbr -a gr "git reset --hard"
abbr -a gu "gitui"
abbr -a c cursor
abbr -a f 'find . -name ""'
abbr -a v 'nvim .'
abbr -a lg lazygit
abbr -a ls 'lsd -l'
abbr -a ll 'lsd -l'
abbr -a snr "sh setupNodeRepo"
abbr -a cl claude

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH
# set -gx PATH $HOME/.rbenv/bin $PATH
# status --is-interactive; and rbenv init - fish | source

# oy-my-posh theme
# ref. https://ohmyposh.dev/docs/installation/customize
oh-my-posh init fish --config /Users/akitomimura/ghq/github.com/mmrakt/fish/themes/jblab_2021.omp.json | source


# pnpm
set -gx PNPM_HOME "/Users/akitomimura/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
