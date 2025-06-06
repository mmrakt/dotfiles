#!/usr/bin/env fish

set dotfiles $HOME/dotfiles

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

switch $argv[1]
    case packages
        install_packages
    case apps
        install_apps
    case '*'
        install_packages
        install_apps
        echo "✅ Done!"
end
