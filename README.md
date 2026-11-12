# tmux-config

My tmux setup: the Omarchy tmux config, sessions that survive a reboot, and a sessionizer to jump
between projects.

## Install

Needs `tmux`, `fzf`, `git` and zsh.

```sh
git clone https://github.com/xforman2/tmux-config ~/projects/tmux-config
~/projects/tmux-config/install.sh
```

`install.sh` can be run again at any time. It:

- links `tmux.conf` to `~/.config/tmux/tmux.conf` (backing up an existing one)
- links `bin/tmux-sessionizer` to `~/.local/bin/tmux-sessionizer`
- clones the plugins (TPM, tmux-resurrect, tmux-continuum) into `~/.config/tmux/plugins`
- adds a line to `~/.zshrc` that sources `shell/tmux.zsh`

Because the files are links, editing them in this repo changes the live config. Reload with
`prefix q`.

## Keys

Prefix is `Ctrl-Space` (`Ctrl-b` works too). `prefix ?` lists every binding.

| Action | Keys |
|---|---|
| Open a project (sessionizer) | `prefix f`, or `Ctrl-f` in a plain shell |
| Pick a session | `prefix s` |
| Previous / next session | `Alt-↑` / `Alt-↓` |
| Last session | `prefix L` |
| New / rename / kill session | `prefix C` / `prefix R` / `prefix K` |
| New / rename / kill window | `prefix c` / `prefix r` / `prefix k` |
| Window 1–9 | `Alt-1` … `Alt-9` |
| Previous / next window | `Alt-←` / `Alt-→` |
| Split pane | `Alt-Enter` / `Alt-Shift-Enter` |
| Move between panes | `Ctrl-Alt-arrows` |
| Kill pane | `Alt-Esc` |
| Zoom pane | `prefix z` |
| Detach | `prefix d` |
| Save / restore sessions now | `prefix Ctrl-s` / `prefix Ctrl-r` |

`t` in the shell attaches to the `main` session, creating it if needed.

## Sessions after a reboot

tmux-continuum saves every session every 15 minutes and restores them when tmux starts. Layouts,
folders and nvim sessions come back; other running programs (dev servers etc.) do not.

## Sessionizer

`tmux-sessionizer` lists the folders inside `~/projects` in fzf. Picking one switches to its
session, creating it in that folder first if needed. Search other folders with
`TMUX_SESSIONIZER_PATHS`, a colon-separated list:

```sh
export TMUX_SESSIONIZER_PATHS="$HOME/projects:$HOME/school"
```

Inspired by ThePrimeagen's tmux-sessionizer.
