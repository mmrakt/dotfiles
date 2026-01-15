# path
set PATH /opt/homebrew/bin $PATH

# set -gx PATH $HOME/.rbenv/bin $PATH

# pnpm
set -gx PNPM_HOME "/Users/$USER_NAME/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
