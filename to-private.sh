find .config/fish/config.fish -type f -exec sed -i '' "s/wj10567/akitomimura/g" {} \;

# Generate Claude settings for private
jq -s '.[0] * .[1]' .claude/settings.base.json .claude/settings.private.json > .claude/settings.json
