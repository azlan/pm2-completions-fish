#!/usr/bin/env fish

# Fish completion script for pm2
# requires jq (JSON processor) - sudo apt install jq
# run `pm2 save` after adding/deleting process

if ! set -q PM2_HOME;
    set -g PM2_HOME ~/.pm2
end

set -l subcommands list info start stop restart log

complete -c pm2 -f -n __fish_use_subcommand -a "list" -d "List all processes"
complete -c pm2 -f -x -n __fish_use_subcommand -a "log" -d "Stream log output"
complete -c pm2 -f -x -n __fish_use_subcommand -a "start" -d "Start a process"
complete -c pm2 -f -x -n __fish_use_subcommand -a "stop" -d "Stop a process"
complete -c pm2 -f -x -n __fish_use_subcommand -a "restart" -d "Restart a process"
complete -c pm2 -f -x -n __fish_use_subcommand -a "info" -d "Describe parameters of a process"

function __pm2_dump_list
    if test -f $PM2_HOME/dump.pm2
        cat $PM2_HOME/dump.pm2 | jq | grep \"name\": | string trim | string sub -s 10 -e -2
        echo all
    end
end

complete -f -c pm2 -x -n "__fish_seen_subcommand_from log" -a '(__pm2_dump_list)'
complete -f -c pm2 -x -n "__fish_seen_subcommand_from start" -a '(__pm2_dump_list)'
complete -f -c pm2 -x -n "__fish_seen_subcommand_from stop" -a '(__pm2_dump_list)'
complete -f -c pm2 -x -n "__fish_seen_subcommand_from restart" -a '(__pm2_dump_list)'
complete -f -c pm2 -x -n "__fish_seen_subcommand_from info" -a '(__pm2_dump_list)'
