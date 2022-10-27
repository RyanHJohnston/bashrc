# This is a config file for bash
# Note: after writing an alias in this file, type:
#				(1) 'chmod 700 ~/.bashrc'
#				(2) './bashrc'
#				(3) 'source ./bashrc'

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
. "$HOME/.cargo/env"

# Alias that updates and cleans entire system.
alias up='sudo apt-get update && sudo apt-get upgrade && sudo apt-get autoremove && sudo apt-get clean && flatpak update'

# Automatically goes to programs in Data Structures CS2124 directory.
alias ds="cd Desktop/'Undergrad Courses'/'Summer 2022'/'Data Structures'/Programs"

# Suppresses annoying errors because of those fucking depracated keys or whatever, fuck miktex and their stupid fucking non gpg keys.
# function open() {

  # gnome-open . &>/dev/null
# }

# This will automatically take you to the vim directory because it's a pain in the fucking ass
# to get there, seriously. I'm trying to script all of these plugins and it's driving me nuts how
# many times I have to cd my way back there!!!!!
alias cdvim="cd dev/vim/"

# This is just some path code for yarn, it was for com.nvim but it sucked ass
# I couldn't get nodejs to work properly.
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# These are custom commands to turn on or off nightlight from the cl
alias night="gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true"
alias day="gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled false"

# Simple command to change terminal theme at anytime
alias theme='bash -c "$(wget -qO- https://git.io/vQgMr)"'

# Commands that takes me to the Fall 2022 directory and/or specific courses of the directory
alias fallsys='cd /Desktop/Systems_Programming/'


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Command that opens the tor browser.
alias tor='flatpak run com.github.micahflee.torbrowser-launcher'

# a modified list comand
alias ls='ls -larth --color --group-directories-first'

# Lists the permissions of a file
alias per='ls -al $1'

# Connects to the utsa vpn
alias utsavpn='ssh ide709@10.100.240.203'
utsa_vpn() {
	read -p "Enter server (201 - 204): " server_name;
	connect_to_vpn="ssh ide709@10.100.240.$server_name"
	let server_name_comparison=$(($server_name >= 201 && $server_name <= 204))
	if [ ~$server_name_comparison ]; then
		echo "Invalid server name, try again."
		return;
	else
		$connect_to_vpn;
		exit 1;
	fi

	exit 0;
}

# Compiles any project with JavaFX
javafx_compile(){
	read -p "Enter file name: " file_name;

	compile="javac --module-path $PATH_TO_FX $file_name"
	execute="java --module-path $PATH_TO_FX $file_name"

	$compile;

	read -p "Execute? (Y/n): " decision;
	case "$decision" in
		'Y')
			$execute
			return 0;
			;;
		'n')
			echo "Not executing."
			return 0;
			;;
		*)
			echo "Invalid input."
			return -1; # User did not write the correct input.
			;;
		esac
	return 0;

}

# We'll have to create an inventory system lmao.


# adding ti_nspire_cx folders to PATH environment variable.
# it's a tool chain build script.

# fancy startup terminal screen
# neofetch;
# printf "UTSA Computer Science and Mathematics, Fall 2022\n"
# printf "$(date)\n"
# printf "Remember Ryan, to undo a tab in chrome is Ctrl+Shift+T\n"
# figlet -cl "UTSA CS"

# setting the java environment variable
export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_341/
export PATH=$JAVA_HOME/bin:$PATH

# this finds specific books
alias comporg="open ~/Desktop/Computer_Systems_a_Programmers_Perspective.pdf"

# slight mod to the cd command, it lists all the files after changing dirs
cdd() {
    cd $1 && ls
}

# takes you to a specific dir for undergrad courses fall 2022
fall2022(){
	printf "Which course?\n"
	printf "[1] Anaysis of Algorithms\n"
	printf "[2] Application Programming\n"
	printf "[3] Systems Programming\n"
	printf "[4] Computer Organization\n"
	read USER_COURSE;

	case $USER_COURSE in
		1)
			cd Desktop/Fall_2022/Analysis_of_Algorithms/ && ls
			;;
		2)
			cd Desktop/Fall_2022/Application_Programming/ && ls
			;;
		3)
			cd Desktop/Fall_2022/Systems_Programming/ && ls
			;;
		4)
			cd Desktop/Fall_2022/Computer_Organization/ && ls
			;;
		*)
			printf "Invalid input, must be 1 - 4\n"
			;;
		esac
}

# a small alias needed for assignment 3 for systems programming fall 2022
alias lsa="\ls -la --time-style='+%Y-%m-%d %H:%M:%S'"

# command that shows selection for books and automatically opens whichever one is picked
# each book is assigned a specific key
books() {
    # cd Desktop/books/ && ls -al
    LIST_COUNT=0  

    for file in ~/Desktop/books/* 
    do
        echo "Processing $file" # always double quote "$f" filename
        LIST_COUNT=$((LIST_COUNT+=1)) 
    done
    
    BOOK_LIST[$((LIST_COUNT))]

}
