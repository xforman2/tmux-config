# Sourced from ~/.zshrc by install.sh

# tmux with no arguments: open the sessionizer, so you pick a project instead of
# piling up unnamed sessions. Any arguments go to tmux unchanged (tmux ls, tmux new -s x, ...).
tmux() {
    if [[ $# -gt 0 ]]; then
        command tmux "$@"
    else
        tmux-sessionizer
    fi
}

# Ctrl-f opens the sessionizer from a plain shell
bindkey -s '^f' 'tmux-sessionizer\n'

# t: attach to "main" if it exists, create it if not
alias t='tmux new-session -A -s main'
