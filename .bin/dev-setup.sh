#!/usr/bin/env fish

set dotfiles (dirname (dirname (status -f)))

function install_packages
    echo "📦 Installing packages..."
    for pkg in (cat $dotfiles/packages.txt | string trim | string match -v '' | string match -v '#*')
        if brew list $pkg >/dev/null 2>&1
            echo "✅ $pkg"
        else
            echo "📥 $pkg"
            brew install $pkg
        end
    end
end

function install_apps
    echo "📱 Installing apps..."
    for app in (cat $dotfiles/apps.txt | string trim | string match -v '' | string match -v '#*')
        if brew list --cask $app >/dev/null 2>&1
            echo "✅ $app"
        else
            echo "📥 $app"
            brew install --cask $app
        end
    end
end

function install_npm_globals
    if test -f $dotfiles/npm-globals.txt
        echo "📦 Installing npm globals..."
        for pkg in (cat $dotfiles/npm-globals.txt | string trim | string match -v '' | string match -v '#*')
            echo "📥 $pkg"
            npm install -g $pkg
        end
    end
end

function install_pnpm_globals
    if test -f $dotfiles/pnpm-globals.txt
        echo "📦 Installing pnpm globals..."
        for pkg in (cat $dotfiles/pnpm-globals.txt | string trim | string match -v '' | string match -v '#*')
            echo "📥 $pkg"
            pnpm add -g $pkg
        end
    end
end

function install_bun_globals
    if test -f $dotfiles/bun-globals.txt
        echo "📦 Installing bun globals..."
        for pkg in (cat $dotfiles/bun-globals.txt | string trim | string match -v '' | string match -v '#*')
            echo "📥 $pkg"
            bun add -g $pkg
        end
    end
end

switch $argv[1]
    case packages
        install_packages
    case apps
        install_apps
    case globals
        install_npm_globals
        install_pnpm_globals
        install_bun_globals
    case '*'
        install_packages
        install_apps
        install_npm_globals
        install_pnpm_globals
        install_bun_globals
        echo "✅ Done!"
end
