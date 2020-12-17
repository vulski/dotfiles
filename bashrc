# Alias definitions.  
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

export EDITOR="nvim" 
source ~/.secrets
export PATH=$PATH:/usr/local/go/bin
export GOPATHV
export PATH=$PATH:$(go env GOPATH)/bin
export GOPATH=$(go env GOPATH)
export PATH=$PATH:~/.local/bin
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export PATH="$PATH:$HOME/scripts" 
export GIT_TERMINAL_PROMPT=1

if [ -d "/home/linuxbrew/.linuxbrew/bin/brew shellenv" ]; then 
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv) 
fi

export KENV_PROJECT_PATH="$HOME/code"

export FZF_DEFAULT_COMMAND='fd --hidden --no-ignore-vcs --exclude .git --exclude node_modules .'; 
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH="$HOME/.symfony/bin:$PATH"

if [ -d $HOME/.cargo/env ]; then
    source $HOME/.cargo/env
    export PATH="$HOME/.cargo/bin:$PATH" 
fi

export PATH="/usr/local/opt/php@7.2/bin:$PATH"
export PATH="/usr/local/opt/php@7.2/sbin:$PATH" 
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export PATH="/usr/local/opt/mysql@5.7/sbin:$PATH" 
export PATH="/usr/local/opt/sqlite/bin:$PATH"

function loadnvm() {
    export NVM_DIR="$HOME/.nvm"
    [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion 
}

eval $(thefuck --alias)

function gtrack() {
    git checkout master ;
    remote=origin ;
    for brname in `
        git branch -r | grep $remote | grep -v master | grep -v HEAD 
        | awk '{gsub(/^[^\/]+\//,"",$1); print $1}'
    `; do
        git branch -D $brname ;
        git checkout -b $brname $remote/$brname ;
    done ;
    git checkout master
}

#TODO
function sqldump (){
ssh ubuntu@ip 'set -o pipefail &&
mysqldump -hhost -uroot -p"pwd \
 --single-transaction --opt --max-allowed-packet=512K  --no-create-db --order-by-primary --quick DBName | gzip' > ~/fileName.sql.gz 

}


#TODO
function sqlimport(){
pv DBname.sql.gz | { echo "set sql_log_bin=0;SET unique_checks=0;SET foreign_key_checks=0;"; zcat; \
echo "SET unique_checks=1;SET foreign_key_checks=1;";} | mysql -uroot -ppassword DBname
}

function phpunit() {
    (./vendor/bin/phpunit $*)
}


export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
