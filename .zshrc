# If you come from bash you might have to change your $PATH.
export PATH=$PATH:/home/nuocman/.spicetify

stty -ixon
autoload -Uz compinit && compinit

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000
export SAVEHIST=1000
setopt SHARE_HISTORY

setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

export EDITOR="emacs -nw"

alias la="ls -a"
alias ll="ls -l"
alias s="cd .."
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
alias clean="{ rm -v *#; rm -v *~; rm -v .*#; rm -v .*~; } 2> /dev/null;"
alias mg='emacs -nw --eval '"'"'(progn (let ((display-buffer-alist `(("^\\*magit: " display-buffer-same-window) ,display-buffer-alist))) (magit-status)) (delete-other-windows))'"' "


ZSH_PLUGIN_DIR=/usr/share/zsh/plugins
ZSH_PLUGINS=(
		zsh-autosuggestions
		zsh-syntax-highlighting
)
for plugin in ${ZSH_PLUGINS[@]}; do
		plugin_script=${ZSH_PLUGIN_DIR}/${plugin}/${plugin}.zsh
		[[ -f $plugin_script ]] && source "${plugin_script}" || echo "Could not initiate '${plugin}' plugin"
done

eval "$(starship init zsh)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
