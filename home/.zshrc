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

# note: filget fonts used are nancyj and "Calvin S"
# note: use Meslo nerd font or some other
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

# ┌┬┐┬ ┬┌─┐┌┬┐┌─┐┌─┐
#  │ ├─┤├┤ │││├┤ └─┐
#  ┴ ┴ ┴└─┘┴ ┴└─┘└─┘
FILE="$HOME/.config/themes/themes.sh"
if [ -f "$FILE" ]; then
    "$FILE"
else
    BAT_THEME="base16"
fi

# Catppuccin Colors
export CATPPUCCIN_FLAVOUR="macchiato"  # Set your desired flavor
source "$HOME/.config/themes/colors.sh"

# Default colors based on Catppuccin theme
COLOR_BACKGROUND="{${COLOR_BACKGROUND:-#F2D0D5}}"
COLOR_MANTLE="{${COLOR_MANTLE:-#BBAF92}}"
COLOR_CRUST="{${COLOR_CRUST:-#A6D5E0}}"
COLOR_ACCENT="{${COLOR_ACCENT:-#F5C2E7}}"
COLOR_GREY="{${COLOR_GREY:-#A6A6A6}}"

# Completion colors
zstyle ':completion:*:warnings' format "%B%F${COLOR_CRUST}No matches for:%f %F${COLOR_MANTLE}%d%b"
zstyle ':completion:*:descriptions' format '%F${COLOR_ACCENT}[-- %d --]%f'
zstyle ':vcs_info:*' formats ' %B%s-[%F${COLOR_MANTLE}%f %F${COLOR_ACCENT}%b%f]-'

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
_comp_options+=(globdots)

zstyle ':completion:*' verbose true
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} 'ma=48;5;197;1'
zstyle ':completion:*' matcher-list \
		'm:{a-zA-Z}={A-Za-z}' \
		'+r:|[._-]=* r:|=*' \
		'+l:|=*'

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
#  folder must exist
HISTFILE=~/history/zhistory
HISTSIZE=500000
SAVEHIST=500000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt INC_APPEND_HISTORY

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
# Prompt setup
PS1="%B%F${COLOR_BACKGROUND}󰕈%f%b  %B%F${COLOR_MANTLE}%n%f%b $(dir_icon)  %B%F${COLOR_CRUST}%~%f%b${vcs_info_msg_0_} %B%F${COLOR_GREY}[0]%f%b%B%F${COLOR_BACKGROUND}%f%b"

function update_prompt() {
    local exit_code=$?
    local exit_color
    if [[ $exit_code -eq 0 ]]; then
        exit_color="%F{green}"  # Green for zero exit code
    else
        exit_color="%F${COLOR_CRUST}"    # Red for nonzero exit code
    fi
    export LAST_COMMAND_INDICATOR="${exit_color}[${exit_code}]"
    export PS1="%B%F${COLOR_BACKGROUND}󰕈%f%b  %B%F${COLOR_MANTLE}%n%f%b $(dir_icon)  %B%F${COLOR_CRUST}%~%f%b${vcs_info_msg_0_} %B${LAST_COMMAND_INDICATOR}%f%b%B%F${COLOR_BACKGROUND}%f%b"
}
add-zsh-hook precmd update_prompt

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

# RPROMPT setup for insert mode and vim mode
export RPROMPT="%B%F${COLOR_BACKGROUND}[INSERT]%f%b%}"
# And also a beam as the cursor
echo -ne '\e[5 q'

# Callback for vim mode change
function zle-keymap-select() {
    local exit_code=${LAST_COMMAND_EXIT_VAL}
    local mode_color="%F{white}"
    # Vim indicator: only supported in these terminals
    if [[ "$TERM" == "tmux-256color" || "$TERM" == "xterm-256color" || "$TERM" == "xterm-kitty" || "$TERM" == "screen-256color" ]]; then
        if [[ $KEYMAP == "vicmd" ]]; then
            mode_color="${COLOR_BACKGROUND}"
            export RPROMPT="%B%F${mode_color}[NORMAL]%f%b"
            # Set block cursor
            echo -ne '\e[1 q'
        else
            mode_color="${COLOR_MANTLE}"
            export RPROMPT="%B#F${mode_color}[INSERT]%f%b"
            # Set beam cursor
            echo -ne '\e[5 q'
        fi
    fi
    # Update PS1 with exit code and mode color
    export PS1="%B%F${COLOR_BACKGROUND}󰕈%f%b  %B%F${COLOR_MANTLE}%n%f%b $(dir_icon)  %B%F${COLOR_CRUST}%~%f%b${vcs_info_msg_0_} %B${LAST_COMMAND_INDICATOR}%f%b%B%F${mode_color}%f%b"

    zle reset-prompt
}
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
# Call necessary for git branch to be shown
    vcs_info
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

