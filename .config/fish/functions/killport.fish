function killport --description "Kill process listening on a given port"
    if test (count $argv) -ne 1
        echo "Usage: killport <port>"
        return 1
    end

    set port $argv[1]
    set pids (lsof -tiTCP:$port -sTCP:LISTEN)

    if test -z "$pids"
        echo "No process listening on port $port"
        return 0
    end

    echo "Killing PID(s): $pids on port $port"
    kill -9 $pids
end
