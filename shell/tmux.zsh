# Sourced from ~/.zshrc by install.sh
# Ctrl-f opens the sessionizer from a plain shell
bindkey -s '^f' 'tmux-sessionizer\n'

# t: attach to "main" if it exists, create it if not
alias t='tmux new-session -A -s main'
