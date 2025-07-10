function fish_greeting
    # MIMU in beautiful uppercase ASCII with gradient colors
    set_color magenta
    echo "███╗   ███╗██╗███╗   ███╗██╗   ██╗"
    set_color ff5f87  # bright pink
    echo "████╗ ████║██║████╗ ████║██║   ██║"
    set_color ff87af  # pink
    echo "██╔████╔██║██║██╔████╔██║██║   ██║"
    set_color ff87d7  # light pink
    echo "██║╚██╔╝██║██║██║╚██╔╝██║██║   ██║"
    set_color cyan
    echo "██║ ╚═╝ ██║██║██║ ╚═╝ ██║╚██████╔╝"
    set_color 5fafff  # light blue
    echo "╚═╝     ╚═╝╚═╝╚═╝     ╚═╝ ╚═════╝"

    set_color normal
    echo ""

    # Add some sparkle
    set_color yellow
    echo "✨ Welcome back! ✨"
    set_color normal
end
