# If you come from bash you might have to change your $PATH.
export PATH=$PATH:/home/nuocman/.spicetify

stty -ixon
autoload -Uz compinit && compinit

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000

setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

export VISUAL="emacs"
export EDITOR="emacs -nw"

alias la="ls -a"
alias ll="ls -l"
alias s="cd .."
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
alias clean="{ rm -v *#; rm -v *~; rm -v .*#; rm -v .*~; } 2> /dev/null;"

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
