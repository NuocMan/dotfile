# If not running interactively, don't do anything
[[ $- != *i* ]] && return

stty -ixon
export HISTFILE=$HOME/.bash_history

alias la="ls -a"
alias ll="ls -l"
alias s="cd .."
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
alias clean="{ rm -v *#; rm -v *~; rm -v .*#; rm -v .*~; } 2> /dev/null;"
alias magit='emacs -nw --eval '"'"'(progn (let ((display-buffer-alist `(("^\\*magit: " display-buffer-same-window) ,display-buffer-alist))) (magit-status)) (delete-other-windows))'"' "

eval "$(starship init bash)"

if [[ -s "$NVM_DIR/bash_completion" ]]; then
  source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi
