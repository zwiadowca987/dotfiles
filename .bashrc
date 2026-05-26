# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

eval "$(oh-my-posh init bash --config ~/.config/ohmyposh/theme.json)"

alias e="emacs"
alias et="emacs -nw"
# alias e="emacsclient -t"
# alias eg="emacsclient -c"
alias orgmode="e ~/Dokumenty/ObsidianVault/org"
alias chat-start="podman start ollama"
alias chat="podman exec -it ollama ollama run qwen2.5:14b-instruct-q4_K_M"
alias chat-file="podman exec -i ollama ollama run qwen2.5:14b-instruct-q4_K_M"
alias start-mc="podman start mc-server && podman exec -it mc-server bash -c 'cd /data && ./start.sh'"
alias comfyui="cd ai-lab/ComfyUI/ && source venv/bin/activate && python main.py"
# alias disk="du -sh -- * .[^.]* 2>/dev/null | sort -hr"
alias n="nvim"

function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

HISTSIZE=50000
HISTFILESIZE=500000
shopt -s histappend

bind 'TAB:menu-complete'
bind '"\e[Z":menu-complete-backward'   # Shift+Tab cofa
. "$HOME/.cargo/env"
