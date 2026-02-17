find .config/fish/config.fish -type f -exec sed -i '' "s/akitomimura/wj10567/g" {} \;

# Enable Claude Code environment variables for work
sed -i '' 's/^# set -x ANTHROPIC/set -x ANTHROPIC/g' .config/fish/conf.d/claude_code.fish
sed -i '' 's/^# set -x OLLAMA/set -x OLLAMA/g' .config/fish/conf.d/claude_code.fish

# Generate Claude settings for work
jq -s '.[0] * .[1]' .claude/settings.base.json .claude/settings.work.json > .claude/settings.json
