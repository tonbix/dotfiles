function fish_greeting
    echo "   date: $(set_color yellow)$(date "+%T %d/%m/%y")$(set_color --reset)"
    echo "   up for: $(set_color yellow)$(uptime -p | string sub -s 4)$(set_color --reset)"
end
