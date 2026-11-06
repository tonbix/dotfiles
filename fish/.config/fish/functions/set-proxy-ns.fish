function set-proxy-ns --description "Run command under proxy using proxyns network namespace"
    if test (count $argv) -eq 0
        echo "Usage: set-proxy-ns <command> [args...]"
        return 1
    end

    set -l ns "proxyns"
    set -l setup_script "$HOME/.dotfiles/scripts/.config/scripts/proxy-ns-up/proxy-ns-up.sh"
    if not test -f "$setup_script"
        set setup_script "$HOME/.config/scripts/proxy-ns-up/proxy-ns-up.sh"
    end

    # Check if network namespace exists; if not, initialize it
    if not ip netns list 2>/dev/null | string match -rq "(^|\s)$ns(\s|\$)"
        echo "Network namespace '$ns' not found. Setting up..."
        if test -f "$setup_script"
            if test (id -u) -eq 0
                bash "$setup_script"
                or return 1
            else
                sudo bash "$setup_script"
                or return 1
            end
        else
            echo "Error: Network namespace '$ns' does not exist and setup script was not found at $setup_script"
            return 1
        end
    end

    # Run the command inside the network namespace
    if test (id -u) -eq 0
        ip netns exec $ns $argv
    else
        sudo -E ip netns exec $ns sudo -E -u (id -un) -- $argv
    end
end
