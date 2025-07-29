#TODO: Find path on the fly
TEXLIVE_DIR=/usr/local/texlive/2025/bin/x86_64-linux
if [ -d "$TEXLIVE_DIR" ]; then
  export PATH="$TEXLIVE_DIR:$PATH"
fi

if [ -n "$BASH_VERSION" ]; then
  if [ -f $HOME/.bashrc ]; then
    source $HOME/.bashrc
  fi
fi

if [ -n $"$ZSH_VERSION" ]; then
  if [ -f $HOME/.zshrc ]; then
    source $HOME/.zshrc
  fi
fi

if which emacs; then
  emacs --daemon
  export EDITOR="emacs -nw"
fi

export SDKMAN_DIR="$HOME/.sdkman"
if [ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]; then
  source "$SDKMAN_DIR/bin/sdkman-init.sh"
fi

export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  source "$NVM_DIR/nvm.sh"  # This loads nvm
fi

if [ -s "$NVM_DIR/bash_completion" ]; then
  source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi
