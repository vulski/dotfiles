# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh 
export LANG=en_US.UTF-8 

if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

export EDITOR="nvim" 
source ~/.secrets

export PATH=$PATH:/usr/local/go/bin
if [ -x "$(command -v go)" ]; then
    export GOPATHV
    export PATH=$PATH:$(go env GOPATH)/bin
    export GOPATH=$(go env GOPATH)
fi
export PATH=$PATH:~/.local/bin
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export PATH="$PATH:$HOME/scripts" 
export GIT_TERMINAL_PROMPT=1

if [ -d "/home/linuxbrew/.linuxbrew/bin/brew shellenv" ]; then 
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv) 
fi

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$HOME/.composer/vendor/bin:$PATH"

if [ -d $HOME/.cargo/env ]; then
    source $HOME/.cargo/env
    export PATH="$HOME/.cargo/bin:$PATH" 
fi

if [ -x "$(command -v go)" ]; then
    eval $(thefuck --alias)
fi

if [ -x "$(command -v rbenv)" ]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
    export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
fi

export PATH="$HOME/.npm-global/bin:$PATH"

bindkey '^ ' autosuggest-accept # Use ctrl space for zsh autocomplete

fpath+=${ZDOTDIR:-~}/.zsh_functions
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
