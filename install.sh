#!/usr/bin/env bash
# Links this tmux setup into place and installs its plugins.
# Safe to run again: existing files are backed up once, links and clones are skipped if present.

set -euo pipefail

repo=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
config_dir="$HOME/.config/tmux"
plugin_dir="$config_dir/plugins"
bin_dir="$HOME/.local/bin"

for cmd in tmux fzf git; do
    if ! command -v "$cmd" > /dev/null; then
        echo "missing: $cmd (install it first, e.g. sudo pacman -S $cmd)" >&2
        exit 1
    fi
done

# link_file <source> <target>: symlink, backing up a real file that is in the way
link_file() {
    local src=$1 dst=$2
    mkdir -p "$(dirname "$dst")"
    if [[ -L $dst && $(readlink "$dst") == "$src" ]]; then
        echo "ok      $dst"
        return
    fi
    if [[ -e $dst || -L $dst ]]; then
        mv "$dst" "$dst.bak.$(date +%Y%m%d%H%M%S)"
        echo "backup  $dst"
    fi
    ln -s "$src" "$dst"
    echo "linked  $dst -> $src"
}

link_file "$repo/tmux.conf" "$config_dir/tmux.conf"
link_file "$repo/bin/tmux-sessionizer" "$bin_dir/tmux-sessionizer"

# Plugins: clone directly so no running tmux server is needed
for plugin in tmux-plugins/tpm tmux-plugins/tmux-resurrect tmux-plugins/tmux-continuum; do
    dest="$plugin_dir/$(basename "$plugin")"
    if [[ -d $dest ]]; then
        echo "ok      $dest"
    else
        git clone -q --depth 1 "https://github.com/$plugin" "$dest"
        echo "cloned  $dest"
    fi
done

# zsh: source the snippet once
zshrc="$HOME/.zshrc"
line="source \"$repo/shell/tmux.zsh\""
if [[ -f $zshrc ]] && grep -qF "$line" "$zshrc"; then
    echo "ok      $zshrc"
else
    printf '\n# tmux-config\n%s\n' "$line" >> "$zshrc"
    echo "added   source line to $zshrc"
fi

if [[ ":$PATH:" != *":$bin_dir:"* ]]; then
    echo "note: $bin_dir is not on your PATH; add it so tmux-sessionizer can be found"
fi

if tmux info > /dev/null 2>&1; then
    tmux source-file "$config_dir/tmux.conf" && echo "reloaded running tmux"
fi

echo "done"
