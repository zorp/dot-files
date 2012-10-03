## VARIABLES
OS=`uname -s`
COLOR_OPTIONS=''

export CLICOLOR=1;

## BASH COLORS
export color_none='\e[0m'
export color_white='\e[1;37m'
export color_black='\e[0;30m'
export color_blue='\e[0;34m'
export color_light_blue='\e[1;34m'
export color_green='\e[0;32m'
export color_light_green='\e[1;32m'
export color_cyan='\e[0;36m'
export color_light_cyan='\e[1;36m'
export color_red="\e[0;31m"
export color_light_red='\e[1;31m'
export color_purple='\e[0;35m'
export color_light_purple='\e[1;35m'
export color_brown='\e[0;33m'
export color_yellow='\e[1;33m'
export color_gray='\e[0;90m'
export color_light_gray='\e[0;37m'


# set PATH so it includes user's private bin if it exists
if [ -d ~/.bin ] ; then
PATH=~/.bin:"${PATH}"
fi
# add local directories
export PATH=/usr/local/bin:/usr/local/sbin:$PATH


## MAC SETTINGS
if [ $OS == "Darwin" ]; then
    # add mamp on mac
    export PATH="/Applications/MAMP/Library/bin:/Applications/MAMP/bin/php/php5.3.6/bin:$PATH"
    #export PATH=$PATH:/Applications/MAMP/bin/php5.2/bin/:/Applications/MAMP/bin/apache2/bin/

    # set editor
    # export EDITOR='mate -w' #TextMate
    export EDITOR='subl -w' #sublime text 2

    GIT_PIECE='$(__git_ps1 " \[$color_yellow\](%s)\[$color_none\]")'

    # bash completion through brew
    if [ -f `brew --prefix`/etc/bash_completion ]; then
        . `brew --prefix`/etc/bash_completion
        GIT_PS1_SHOWDIRTYSTATE=true
    fi

    # color options for ls
    COLOR_OPTIONS='-G'

	export SSDUMPNAME=/tmp/ssdump.png
	function ssdump() {
	  echo "Select window to dump"
	  screencapture -i ${SSDUMPNAME}
	  curl -F file=@"${SSDUMPNAME}" dl.gs
	  echo
	}
	alias ssdump=ssdump

    # alias specific for mac
    alias git='hub'
    alias m='mate .'
    alias top='top -o cpu'
    alias logs='tail -f /Applications/MAMP/logs/php_error.log /Applications/MAMP/logs/access.log /Applications/MAMP/logs/error.log /Applications/MAMP/logs/mysql_error_log /Applications/MAMP/logs/mysql_error_log.err /Applications/MAMP/logs/apache_error_log'

    # add z, the new j
	. `brew --prefix`/etc/profile.d/z.sh #Installed by brew
    #. ~/.bin/z.sh
fi

## LINUX SETTINGS
if [ $OS == "Linux" ]; then
    # bash completions
    . /etc/bash_completion

    # set editor
    export EDITOR='vim'

    # color options for ls
    COLOR_OPTIONS='--color=auto'
fi

## USE COLORS FOR LS
if [ $TERM == "xterm-256color" -o $TERM == "xterm-color" ]; then
    alias ls="ls $COLOR_OPTIONS"
    alias ll="ls -lh $COLOR_OPTIONS"
    alias la="ls -a $COLOR_OPTIONS"
    alias lal="ls -lha $COLOR_OPTIONS"
fi


## GENERAL SETTINGS
# bash smart tab completion
bind "set show-all-if-ambiguous On"

# general aliases
alias g="git"
alias profileme="history | awk '{print \$2}' | awk 'BEGIN{FS=\"|\"}{print \$1}' | sort | uniq -c | sort -nr | head -n 20"

# force my custom mamp php.ini on cli
alias php="php -c /Applications/MAMP/bin/php/php5.3.6/conf/php.ini"

# work related aliases
alias latto-dir="cd ~/Sites/work/ding/ding2tal.ting.dk/profiles/ding2/themes/latto/"
alias d-cc="drush cc all"
# if Fogbugz php cli exist add an alias
if [ -d ~/.fogbugz-php-cli ] ; then
  alias fb="php ~/.fogbugz-php-cli/working.php"
fi
alias brond="~/Sites/work/ding/aakb_ssh_tunnel.sh"

# prompt
DATE_PIECE="\[${color_gray}\]\$(date '+%a %H:%M:%S')\[${color_none}\]"
export PS1="${DATE_PIECE} \u\[${color_green}\]@\[${color_none}\]\h \[${color_gray}\]\w${GIT_PIECE}\n\[${color_green}\]\$\[${color_none}\] "
