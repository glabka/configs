# __________________________________________________
#/                                                  \
#|                       dP                         |
#|                       88                         |
#|     d888888b .d8888b. 88d888b. 88d888b. .d8888b. |
#|        .d8P' Y8ooooo. 88'  `88 88'  `88 88'  `"" |
#|  dP  .Y8P          88 88    88 88       88.  ... |
#|  88 d888888P `88888P' dP    dP dP       `88888P' |
#|                                                  |
#|                                                  |
#\                                                  /
# --------------------------------------------------
#    \
#     \
#         .--.
#        |o_o |
#        |:_/ |
#       //   \ \
#      (|     | )
#     /'\_   _/`\
#     \___)=(___/

# note filget fonts used are nancyj and "Calvin S"
# If not running interactively, don't do anything
[[ $- != *i* ]] && return


#  ┬  ┬┌─┐┬─┐┌─┐
#  └┐┌┘├─┤├┬┘└─┐
#   └┘ ┴ ┴┴└─└─┘
export VISUAL="${EDITOR}"
export EDITOR='geany'
export BROWSER='firefox'
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
export SUDO_PROMPT="Deploying root access for %u. Password pls: "
export BAT_THEME="base16"

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

#  ┬  ┌─┐┌─┐┌┬┐  ┌─┐┌┐┌┌─┐┬┌┐┌┌─┐
#  │  │ │├─┤ ││  ├┤ ││││ ┬││││├┤
#  ┴─┘└─┘┴ ┴─┴┘  └─┘┘└┘└─┘┴┘└┘└─┘
autoload -Uz compinit

for dump in ~/.config/zsh/zcompdump(N.mh+24); do
  compinit -d ~/.config/zsh/zcompdump
done

compinit -C -d ~/.config/zsh/zcompdump

autoload -Uz add-zsh-hook
autoload -Uz vcs_info
precmd () { vcs_info }
_comp_options+=(globdots)

zstyle ':completion:*' verbose true
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} 'ma=48;5;197;1'
zstyle ':completion:*' matcher-list \
		'm:{a-zA-Z}={A-Za-z}' \
		'+r:|[._-]=* r:|=*' \
		'+l:|=*'
zstyle ':completion:*:warnings' format "%B%F{red}No matches for:%f %F{magenta}%d%b"
zstyle ':completion:*:descriptions' format '%F{yellow}[-- %d --]%f'
zstyle ':vcs_info:*' formats ' %B%s-[%F{magenta}%f %F{yellow}%b%f]-'

#  ┬ ┬┌─┐┬┌┬┐┬┌┐┌┌─┐  ┌┬┐┌─┐┌┬┐┌─┐
#  │││├─┤│ │ │││││ ┬   │││ │ │ └─┐
#  └┴┘┴ ┴┴ ┴ ┴┘└┘└─┘  ─┴┘└─┘ ┴ └─┘
expand-or-complete-with-dots() {
  echo -n "\e[31m…\e[0m"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

#  ┬ ┬┬┌─┐┌┬┐┌─┐┬─┐┬ ┬
#  ├─┤│└─┐ │ │ │├┬┘└┬┘
#  ┴ ┴┴└─┘ ┴ └─┘┴└─ ┴
HISTFILE=~/.config/zsh/zhistory
HISTSIZE=5000
SAVEHIST=5000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

#  ┌─┐┌─┐┬ ┬  ┌─┐┌─┐┌─┐┬    ┌─┐┌─┐┌┬┐┬┌─┐┌┐┌┌─┐
#  ┌─┘└─┐├─┤  │  │ ││ ││    │ │├─┘ │ ││ ││││└─┐
#  └─┘└─┘┴ ┴  └─┘└─┘└─┘┴─┘  └─┘┴   ┴ ┴└─┘┘└┘└─┘
setopt AUTOCD              # change directory just by typing its name
setopt PROMPT_SUBST        # enable command substitution in prompt
setopt MENU_COMPLETE       # Automatically highlight first element of completion menu
setopt LIST_PACKED	   # The completion menu takes less space.
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD    # Complete from both ends of a word.

#  ┌┬┐┬ ┬┌─┐  ┌─┐┬─┐┌─┐┌┬┐┌─┐┌┬┐
#   │ ├─┤├┤   ├─┘├┬┘│ ││││├─┘ │
#   ┴ ┴ ┴└─┘  ┴  ┴└─└─┘┴ ┴┴   ┴
function dir_icon {
  if [[ "$PWD" == "$HOME" ]]; then
    echo "%B%F{cyan}%f%b"
  else
    echo "%B%F{cyan}%f%b"
  fi
}
#󰕈
PS1='%B%F{blue}󰕈%f%b  %B%F{magenta}%n%f%b $(dir_icon)  %B%F{red}%~%f%b${vcs_info_msg_0_} %(?.%B%F{green}.%F{red})%f%b '

#  ┌─┐┬  ┬ ┬┌─┐┬┌┐┌┌─┐
#  ├─┘│  │ ││ ┬││││└─┐
#  ┴  ┴─┘└─┘└─┘┴┘└┘└─┘
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#  ┌─┐┬  ┬┌─┐┌─┐
#  ├─┤│  │├─┤└─┐
#  ┴ ┴┴─┘┴┴ ┴└─┘
alias bat="batcat --theme=base16"
alias ls='ls --color'
alias ls='eza --icons=always --color=always -a'
alias ll='eza --icons=always --color=always -la'


#  ┬  ┬┬┌┬┐  ┌┬┐┌─┐┌┬┐┌─┐  ┬ ┬┬┌┬┐┬ ┬  ┬┌┐┌┌┬┐┬┌─┐┌─┐┌┬┐┌─┐┬─┐
#  └┐┌┘││││  ││││ │ ││├┤   ││││ │ ├─┤  ││││ ││││  ├─┤ │ │ │├┬┘
#   └┘ ┴┴ ┴  ┴ ┴└─┘─┴┘└─┘  └┴┘┴ ┴ ┴ ┴  ┴┘└┘─┴┘┴└─┘┴ ┴ ┴ └─┘┴└─
bindkey -v
## By default, we have insert mode shown on right hand side
export RPROMPT="%B%F{blue}[INSERT]%f%b%}"

# And also a beam as the cursor
echo -ne '\e[5 q'

# Callback for vim mode change
function zle-keymap-select () {
    # Only supported in these terminals

    if [ "$TERM" = "tmux-256color" ] || [ "$TERM" = "xterm-256color" ] || [ "$TERM" = "xterm-kitty" ] || [ "$TERM" = "screen-256color" ]; then
        if [ $KEYMAP = vicmd ]; then
            # Command mode
            export RPROMPT="%B%F{green}[NORMAL]%f%b%}"


            # Set block cursor
            echo -ne '\e[1 q'
        else
            # Insert mode
            export RPROMPT="%B%F{blue}[INSERT]%f%b%}"

            # Set beam cursor
            echo -ne '\e[5 q'
        fi
    fi
    zle reset-prompt
}

# Bind the callback
zle -N zle-keymap-select

# Reduce latency when pressing <Esc>
 export KEYTIMEOUT=1
 
#  ┌┬┐┬ ┬  ┌┐ ┬┌┐┌┌┬┐┬┌┐┌┌─┐┌─┐
#  │││└┬┘  ├┴┐││││ │││││││ ┬└─┐
#  ┴ ┴ ┴   └─┘┴┘└┘─┴┘┴┘└┘└─┘└─┘
bindkey '^ ' autosuggest-accept
#bindkey '^I' complete-word
bindkey '^I'         menu-complete
bindkey "$terminfo[kcbt]" reverse-menu-complete
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey '^H' backward-kill-word
bindkey '5~' kill-word
bindkey '^R' history-incremental-search-backward

#  ┌─┐─┐ ┬┌┬┐┬─┐┌─┐┌─┐┌┬┐
#  ├┤ ┌┴┬┘ │ ├┬┘├─┤│   │
#  └─┘┴ └─ ┴ ┴└─┴ ┴└─┘ ┴
extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1       ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
 }
 
#  ┌┬┐┌┬┐┬ ┬─┐ ┬
#   │ ││││ │┌┴┬┘
#   ┴ ┴ ┴└─┘┴ └─
[[ -z "$TMUX" ]] && exec tmux

#  ┬  ┌─┐┌┐┌┌─┐  ┌─┐┌─┐┌┬┐┌┬┐┌─┐┌┐┌┌┬┐┌─┐  ┌┐ ┌─┐┌─┐┌─┐
#  │  │ │││││ ┬  │  │ │││││││├─┤│││ ││└─┐  ├┴┐├┤ ├┤ ├─┘
#  ┴─┘└─┘┘└┘└─┘  └─┘└─┘┴ ┴┴ ┴┴ ┴┘└┘─┴┘└─┘  └─┘└─┘└─┘┴
function check_command_prefix() {
    local input_string="$1"
    shift
    local ignored_commands=("nvim" "vim" "vi" "ssh" "intellij-idea" "firefox")

    for cmd in "${ignored_commands[@]}"; do
        if [[ "$input_string" == "$cmd "* || "$input_string" == "$cmd" ]]; then
            return 0  # Return success if it matches
        fi
    done

    return 1  # Return failure if no match found
}

preexec () {
    # Note the date when the command started, in unix time.
    CMD_START_DATE=$(date +%s)
    # Store the command that we're running.
    CMD_NAME=$1
}

precmd () {
    # Proceed only if we've run a command in the current shell.
    if ! [[ -z $CMD_START_DATE ]] && ! check_command_prefix "$CMD_NAME"; then
        # Note current date in unix time
        CMD_END_DATE=$(date +%s)
        # Store the difference between the last command start date vs. current date.
        CMD_ELAPSED_TIME=$(($CMD_END_DATE - $CMD_START_DATE))
        # Store an arbitrary threshold, in seconds.
        CMD_NOTIFY_THRESHOLD=60

        if [[ $CMD_ELAPSED_TIME -gt $CMD_NOTIFY_THRESHOLD ]]; then
            # Beep or visual bell if the elapsed time (in seconds) is greater than threshold
            print -n '\a'
            # Send a notification
            notify-send 'Job finished' "The job \"$CMD_NAME\" has finished."
        fi
    fi
}

