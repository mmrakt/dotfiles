function repo
    if test (count $argv) -lt 2
        echo "Usage: repo g <github-url>"
        return 1
    end

    set subcmd $argv[1]
    set url $argv[2]

    if test "$subcmd" != "g"
        echo "Unknown subcommand: $subcmd"
        echo "Usage: repo g <github-url>"
        return 1
    end

    # Remove .git suffix if present
    set url (string replace -r '\.git$' '' $url)
    # Remove trailing slash if present
    set url (string replace -r '/$' '' $url)

    # Parse org and repo from URL
    # Supports: https://github.com/org/repo or https://github.com/org/repo.git
    set parsed (string match -r 'https?://[^/]+/([^/]+)/([^/]+)' $url)

    if test (count $parsed) -lt 3
        echo "Invalid URL format: $url"
        echo "Expected: https://github.com/org/repo"
        return 1
    end

    set org $parsed[2]
    set repo_name $parsed[3]
    set base_dir "$HOME/ghq/github.com"
    set target_dir "$base_dir/$org/$repo_name"

    # Create org directory if not exists
    if not test -d "$base_dir/$org"
        mkdir -p "$base_dir/$org"
    end

    # Clone if target doesn't exist
    if test -d "$target_dir"
        echo "Already exists: $target_dir"
        cd $target_dir
    else
        echo "Cloning to: $target_dir"
        git clone "$url.git" "$target_dir"
        and cd $target_dir
    end
end
