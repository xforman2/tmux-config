# Sourced from ~/.zshrc by install.sh

# tmux with no arguments: attach and open the session list, so you pick where to go
# instead of piling up new sessions. With no sessions yet, start one.
# Any arguments go to tmux unchanged (tmux ls, tmux new -s x, ...).
tmux() {
    if [[ $# -gt 0 ]]; then
        command tmux "$@"
    elif command tmux has-session 2> /dev/null; then
        command tmux attach-session \; choose-tree -Zs
    else
        command tmux new-session
    fi
}

# Ctrl-f opens the sessionizer from a plain shell
bindkey -s '^f' 'tmux-sessionizer\n'

# t: attach to "main" if it exists, create it if not
alias t='tmux new-session -A -s main'
