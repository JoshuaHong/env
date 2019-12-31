#
# $HOME/.bashrc
#

# ========== Init ========== {{{
# If not running interactively, don't do anything.
[[ "$-" != *i* ]] && return

# Autostart X at login.
if systemctl -q is-active graphical.target \
    && [[ ! "$DISPLAY" && "$XDG_VTNR" -eq 1 ]]; then
  exec startx
fi
# }}}

# ========== General ========== {{{
# Primary prompt.
gitbranch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
PS1="\[\e[31m\][\[\e[m\]\[\e[33m\]\u\[\e[m\]\[\e[32m\]@\[\e[m\]\[\e[34m\]\h\
\[\e[m\]\[\e[94m\] \W\[\e[35m\]\$(gitbranch)\[\e[m\]\[\e[m\]\[\e[31m\]]\
\[\e[m\]\[\e[36m\]$\[\e[m\]\[\e[39m\] "

# Use Vim key bindings.
set -o vi

# Use FZF.
[ -f "$HOME/.fzf.bash" ] && source "$HOME/.fzf.bash"

# Auto cd when entering just a path name.
shopt -s autocd

# Auto correct directory names.
shopt -s cdspell
shopt -s dirspell
# }}}

# ========== Exports ========== {{{
# Set default terminal emulator.
export TERMINAL=/usr/bin/alacritty

# Set default editor.
export EDITOR=/usr/bin/nvim

# Enable FZF file previews.
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null \
    || cat {} || tree -C {}) 2> /dev/null | head -200'"

# Add key bindings for scrolling FZF preview windows.
export FZF_DEFAULT_OPTS="--bind ctrl-h:preview-up,ctrl-l:preview-down"

# Enable colorized GCC output.
export GCC_COLORS="error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01 \
    :quote=01"
# }}}

# ========== Aliases ========== {{{
# ========== General ========== {{{
# Cd and ls, and cd to parent directory for every ".".
cd() {
  local dir="$1"
  if [[ "$dir" =~ ^(\.)+$ ]]; then
    local MYOLDPWD="$PWD"
    for ((i=0; i<"${#dir}"; ++i)); do
      builtin cd "../"
    done
    OLDPWD="$MYOLDPWD"
    pwd
  else
    builtin cd "$@"
  fi

  ls --color=auto
}

alias cp="cp -r"
alias diff="diff --color"
alias ls="ls --color=auto"
# }}}

# ========== Git ========== {{{
alias ga="git add"
alias gaa="git add --all"
alias gb="git branch"
alias gbd="git branch delete"
alias gc="git commit"
alias gcl="git clone"
alias gcm="git commit --message"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gcom="git checkout master"
alias gcod="git checkout develop"
alias gd="git diff"
alias gdh="git diff HEAD"
alias gi="git init"
alias gl="git log --all --decorate --graph --oneline --date=short --pretty=format:'%C(yellow)%h%Creset%C(red)%C(bold)%d%Creset%C(white)(%cd)%Creset %s'"
alias gm="git merge"
alias gpl="git pull"
alias gps="git push"
alias grb="git rebase"
alias grs="git reset"
alias gs="git status"
alias gst="git stash"
alias gstp="git stash pop"
# }}}

# ========== Scripts ========== {{{
alias timer='$HOME/scripts/general/timer.sh'
# }}}
# }}}
