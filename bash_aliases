# terraform
alias tf='terraform'

#tmux
alias tm='tmux'
alias tma='tmux a '

# docker 
alias d="docker"
alias dk="docker container"
alias dv="docker volume"

# docker-compose
alias dc="docker-compose"
alias dce="docker-compose exec"

# git 
alias gl="git pull"
alias whoops="git reset --hard HEAD"
alias whops="git reset --hard HEAD"
alias ga="git add"
alias gall="git add --a"
alias gk='git commit'
alias gs='git status'
alias gp='git push'
alias gsup='git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)'
alias gclean="git branch --merged | grep  -v '\\*\\|master\\|develop' | xargs -n 1 git branch -d"
alias gcleanr="git branch -r --merged | grep -v master | sed 's/origin\///' | xargs -n 1 git push --delete origin"
alias gc="git checkout"
alias gupdate="git fetch -a && git pull -a"

# gitflow
alias gfl="git flow"

# PHPUnit
alias p='phpunit'
alias pf='phpunit --filter '
alias phpunit='php vendor/bin/phpunit'

# PHP specific ctags settings.
alias ctagsp="ctags -R --fields=+aimlS --languages=php"
alias phpctags="php ~/bin/phpctags ."

# PHP 
alias cmp='composer'
alias cmpd='composer dump'

# Laravel
alias art='php artisan'

alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../../'

#-------------------------------------------------------------
# The 'ls' family
#-------------------------------------------------------------
if [[ $platform == 'linux' ]]; then
	alias ls='ls -h --color=auto'
	alias l.='ls -d .* --color=auto'
	alias ll="ls -lv --group-directories-first"
fi
alias lx='ls -lXB'         #  Sort by extension.
alias lk='ls -lSr'         #  Sort by size, biggest last.
alias lt='ls -ltr'         #  Sort by date, most recent last.
alias lc='ls -ltcr'        #  Sort by/show change time,most recent last.
alias lu='ls -ltur'        #  Sort by/show access time,most recent last.

# The ubiquitous 'll': directories first, with alphanumeric sorting:
alias lm='ll |more'        #  Pipe through 'more'
alias lr='ll -R'           #  Recursive ls.
alias la='ll -A'           #  Show hidden files.
alias tree='tree -Csuh'    #  Nice alternative to 'recursive ls' ...


#-------------------------------------------------------------
# Spelling typos
#-------------------------------------------------------------

alias sl='ls'
alias xs='cd'
alias vf='cd'
alias moer='more'
alias moew='more'
alias kk='ll'


#-------------------------------------------------------------
# Misc
#-------------------------------------------------------------

alias grep='grep --color=auto'

alias sha1='openssl sha1'

alias mkdir='mkdir -pv'

alias diff='colordiff'
alias mount='mount |column -t'

alias h='history'
alias j='jobs -l'

alias update='sudo apt-get update && sudo apt-get upgrade'
alias apt-get='sudo apt-get'

alias wanip='dig +short myip.opendns.com @resolver1.opendns.com'

alias sym="symfony"
alias sc="symfony console"


alias nod="export PATH=./node_modules/.bin:$PATH"

alias mt="php bin/phpunit -d memory_limit=2048M --bootstrap vendor/autoload.php --configuration app/phpunit.xml.dist"
alias mtf="php bin/phpunit  --bootstrap vendor/autoload.php --configuration app/phpunit.xml.dist --filter "

alias count="ls -1 | wc -l"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

