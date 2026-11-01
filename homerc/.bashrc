# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# ── history ──────────────────────────────────────────────
HISTCONTROL=ignoreboth:erasedups
shopt -s histappend
shopt -s histverify
shopt -s checkwinsize
HISTSIZE=10000
HISTFILESIZE=20000
HISTTIMEFORMAT='%F %T '

# ── prompt ───────────────────────────────────────────────
__color_prompt=no
if [ -x /usr/bin/tput ] && [ "$(tput colors 2>/dev/null)" -ge 8 ] 2>/dev/null; then
    __color_prompt=yes
fi
if [ "$__color_prompt" = yes ]; then
    PS1='\[\033[38;2;137;180;250m\]\u@\h\[\033[00m\]:\[\033[38;2;245;194;231m\]\w\[\033[0m\]\$ '
    #PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='\u@\h:\w\$ '
fi
unset __color_prompt

# window title
case "$TERM" in
xterm*|rxvt*|alacritty*|ghostty*|foot*|konsole*)
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
    ;;
esac

# ── colors & aliases ─────────────────────────────────────
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias grep='grep --color=auto'
fi
[ -x /usr/bin/fdfind ] && alias fd='fdfind'
alias ..='cd ..'
alias ...='cd ../..'

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# your own aliases
[ -f ~/.bash_aliases ] && . ~/.bash_aliases

# ── completion (skip if already loaded by /etc/profile.d) ─
if [ -z "${BASH_COMPLETION_VERSINFO-}" ] && ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# ── PATH (idempotent) ────────────────────────────────────
__path_prepend() {
    [ -d "$1" ] || return 0
    case ":$PATH:" in
        *":$1:"*) ;;
        *) PATH="$1:$PATH" ;;
    esac
}
__path_prepend "$HOME/.local/bin"
__path_prepend "$HOME/.opencode/bin"
__path_prepend "$HOME/.local/share/JetBrains/Toolbox/scripts"
unset -f __path_prepend
export PATH


# INIT
fastfetch
