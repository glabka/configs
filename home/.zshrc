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

# NOTE: filget fonts used are nancyj and "Calvin S"
# NOTE: use Meslo nerd font or some other

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


#  ┬  ┬┌─┐┬─┐┌─┐
#  └┐┌┘├─┤├┬┘└─┐
#   └┘ ┴ ┴┴└─└─┘
#  (vars)

export VISUAL="${EDITOR}"
export EDITOR='geany'
export BROWSER='firefox'
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
export SUDO_PROMPT="Deploying root access for %u. Password pls: "
local char_arrow="›"   #Unicode: \u203a

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

# ┌┬┐┬ ┬┌─┐┌┬┐┌─┐┌─┐
#  │ ├─┤├┤ │││├┤ └─┐
#  ┴ ┴ ┴└─┘┴ ┴└─┘└─┘
#  (themes)

export CATPPUCCIN_FLAVOUR="macchiato"  # Set your desired flavor

# Catppuccin Colors
if [ -f "$HOME/.config/themes/colors.sh" ]; then
    # NOTE: use chmod 700 on this file for security
    source "$HOME/.config/themes/colors.sh"
fi

# Default colors based on Catppuccin theme
COLOR_BLUE="{${COLOR_BLUE:-blue}}"
COLOR_MAGENTA="{${COLOR_MAUVE:-magenta}}"
COLOR_RED="{${COLOR_RED:-red}}"
COLOR_YELLOW="{${COLOR_YELLOW:-yellow}}"
COLOR_GREY="{${COLOR_SURFACE_2:-grey}}"
COLOR_CYAN="{${COLOR_SAPPHIRE:-cyan}}"
COLOR_ORANGE="{${COLOR_PEACH:-orange}}"
COLOR_GREEN="{${COLOR_GREEN:-green}}"

# Completion colors
local completion_descriptions="%B%F{85} ${char_arrow} %f%%F{COLOR_GREEN}%d%b%f"
local completion_warnings="%F{COLOR_yellow} ${char_arrow} %fno matches for %F{COLOR_GREEN}%d%f"
local completion_error="%B%F{COLOR_RED} ${char_arrow} %f%e %d error"

zstyle ':completion:*:warnings' format "%B%F${COLOR_RED}No matches for:%f %F${COLOR_MAGENTA}%d%b"
zstyle ':completion:*:descriptions' format '%F${COLOR_YELLOW}[-- %d --]%f'
zstyle ':vcs_info:*' formats ' %B%s-[%F${COLOR_MAGENTA}%f %F${COLOR_YELLOW}%b%f]-'

# some other nice colors
LS_COLORS=$LS_COLORS:"di=36":"ln=30;45":"so=34:pi=33":"ex=35":"bd=34;46":"cd=34;43":"su=30;41":"sg=30;46":"ow=30;43":"tw=30;42":"*.js=0;33":"*.json=33":"*.jsx=38;5;117":"*.ts=38;5;75":"*.css=38;5;27":"*.scss=38;5;169"
export LS_COLORS

#  ┬  ┌─┐┌─┐┌┬┐  ┌─┐┌┐┌┌─┐┬┌┐┌┌─┐
#  │  │ │├─┤ ││  ├┤ ││││ ┬││││├┤
#  ┴─┘└─┘┴ ┴─┴┘  └─┘┘└┘└─┘┴┘└┘└─┘
#  (load engine)

autoload -Uz compinit

# NOTE: ~/.config/zsh direcotory must exist for this code to work
for dump in ~/.config/zsh/zcompdump(N.mh+24); do
  compinit -d ~/.config/zsh/zcompdump
  # chmod for security messure
  chmod 600 ~/.config/zsh/zcompdump
done

compinit -C -d ~/.config/zsh/zcompdump

autoload -Uz add-zsh-hook
autoload -Uz vcs_info

zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS} "ma=189;5;255;48;5;24"

zstyle ':completion:*' verbose true
zstyle ':completion:*:*:*:*:*' menu select format $completion_descriptions
zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS} "ma=38;5;253;48;5;23"
zstyle ':completion:*' matcher-list \
		'm:{a-zA-Z}={A-Za-z}' \
		'+r:|[._-]=* r:|=*' \
		'+l:|=*'
zstyle ':completion:*:*:*:*:corrections' format $completion_error

_comp_options+=(globdots)

#  ┬ ┬┌─┐┬┌┬┐┬┌┐┌┌─┐  ┌┬┐┌─┐┌┬┐┌─┐
#  │││├─┤│ │ │││││ ┬   │││ │ │ └─┐
#  └┴┘┴ ┴┴ ┴ ┴┘└┘└─┘  ─┴┘└─┘ ┴ └─┘
#  (waiting dots)

expand-or-complete-with-dots() {
  echo -n "\e[31m…\e[0m"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots

#  ┬ ┬┬┌─┐┌┬┐┌─┐┬─┐┬ ┬
#  ├─┤│└─┐ │ │ │├┬┘└┬┘
#  ┴ ┴┴└─┘ ┴ └─┘┴└─ ┴
#  (history)

#  directory must exist (NOTE: use chmod 600 for security)
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
#  (zsh cool options)

setopt AUTOCD              # change directory just by typing its name
setopt PROMPT_SUBST        # enable command substitution in prompt
setopt MENU_COMPLETE       # Automatically highlight first element of completion menu
setopt LIST_PACKED	   # The completion menu takes less space.
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD    # Complete from both ends of a word.

#  ┌┬┐┬ ┬┌─┐  ┌─┐┬─┐┌─┐┌┬┐┌─┐┌┬┐
#   │ ├─┤├┤   ├─┘├┬┘│ ││││├─┘ │
#   ┴ ┴ ┴└─┘  ┴  ┴└─└─┘┴ ┴┴   ┴
#  (the prompt)

function dir_icon {
  if [[ "$PWD" == "$HOME" ]]; then
    echo "%B%F${COLOR_CYAN}%f%b"
  else
    echo "%B%F${COLOR_CYAN}%f%b"
  fi
}

#󰕈
# Prompt setup
PS1="%B%F${COLOR_BLUE}󰕈%f%b  %B%F${COLOR_MAGENTA}%n%f%b $(dir_icon)  %B%F${COLOR_RED}%~%f%b%${vcs_info_msg_0_} %B%F${COLOR_GREY}[0]%f%b%B%F${COLOR_MAGENTA}%f%b"

function update_prompt() {
    local exit_code=$?
    local exit_color
    if [[ $exit_code -eq 0 ]]; then
        exit_color="%F${COLOR_GREEN}"  # Green for zero exit code
    else
        exit_color="%F${COLOR_RED}"    # Red for nonzero exit code
    fi
    export LAST_COMMAND_INDICATOR="${exit_color}[${exit_code}]"
    export PS1="%B%F${COLOR_BLUE}󰕈%f%b  %B%F${COLOR_MAGENTA}%n%f%b $(dir_icon)  %B%F${COLOR_RED}%~%f%b${vcs_info_msg_0_} %B${LAST_COMMAND_INDICATOR}%f%b%B%F${COLOR_MAGENTA}%f%b"
}
add-zsh-hook precmd update_prompt

#  ┌─┐┬  ┬ ┬┌─┐┬┌┐┌┌─┐
#  ├─┘│  │ ││ ┬││││└─┐
#  ┴  ┴─┘└─┘└─┘┴┘└┘└─┘
#  (plugins)

# NOTE: install plugins for them to work
if [ -f "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
if [ -f "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

#  ┌─┐┬  ┬┌─┐┌─┐
#  ├─┤│  │├─┤└─┐
#  ┴ ┴┴─┘┴┴ ┴└─┘
#  (alias)

# On some system bat is called batcat
if command -v bat >/dev/null 2>&1; then
    BAT=bat
elif command -v batcat >/dev/null 2>&1; then
    BAT=batcat
fi
flavor_capital_letter=$(echo "$CATPPUCCIN_FLAVOUR" | sed 's/.*/\u&/')

if $BAT --list-themes | grep -q "Catppuccin"; then
    alias bat="$BAT --theme=\"Catppuccin $flavor_capital_letter\""
else
    alias bat="$BAT --theme=base16"
fi
alias ls='ls --color'
alias ls='eza --icons=always --color=always -a'
alias ll='eza --icons=always --color=always -la'


#  ┬  ┬┬┌┬┐  ┌┬┐┌─┐┌┬┐┌─┐  ┬ ┬┬┌┬┐┬ ┬  ┬┌┐┌┌┬┐┬┌─┐┌─┐┌┬┐┌─┐┬─┐
#  └┐┌┘││││  ││││ │ ││├┤   ││││ │ ├─┤  ││││ ││││  ├─┤ │ │ │├┬┘
#   └┘ ┴┴ ┴  ┴ ┴└─┘─┴┘└─┘  └┴┘┴ ┴ ┴ ┴  ┴┘└┘─┴┘┴└─┘┴ ┴ ┴ └─┘┴└─
#  (vim mode with indicator)
bindkey -v
## By default, we have insert mode shown on right hand side

# RPROMPT setup for insert mode and vim mode
INSERT_COLOR="${COLOR_MAGENTA}"
export RPROMPT="%B%F${INSERT_COLOR}[INSERT]%f%b%}"
# And also a beam as the cursor
echo -ne '\e[5 q'

# Callback for vim mode change
function zle-keymap-select() {
    local exit_code=${LAST_COMMAND_EXIT_VAL}
    # Vim indicator: only supported in these terminals
    mode_color=
    if [[ "$TERM" == "tmux-256color" || "$TERM" == "xterm-256color" || "$TERM" == "xterm-kitty" || "$TERM" == "screen-256color" ]]; then
        if [[ $KEYMAP == "vicmd" ]]; then
            mode_color="${COLOR_GREY}"
            export RPROMPT="%B%F${mode_color}[NORMAL]%f%b"
            # Set block cursor
            echo -ne '\e[1 q'
        else
            mode_color="${INSERT_COLOR}"
            export RPROMPT="%B%F${mode_color}[INSERT]%f%b"
            # Set beam cursor
            echo -ne '\e[5 q'
        fi
    fi
    # Update PS1 with exit code and mode color
    export PS1="%B%F${COLOR_BLUE}󰕈%f%b  %B%F${COLOR_MAGENTA}%n%f%b $(dir_icon)  %B%F${COLOR_RED}%~%f%b${vcs_info_msg_0_} %B${LAST_COMMAND_INDICATOR}%f%b%B%F${mode_color}%f%b"

    zle reset-prompt
}
zle -N zle-keymap-select

# Reduce latency when pressing <Esc>
export KEYTIMEOUT=1
 
#  ┌┬┐┬ ┬  ┌┐ ┬┌┐┌┌┬┐┬┌┐┌┌─┐┌─┐
#  │││└┬┘  ├┴┐││││ │││││││ ┬└─┐
#  ┴ ┴ ┴   └─┘┴┘└┘─┴┘┴┘└┘└─┘└─┘
#  (my bindings)
bindkey '^ ' autosuggest-accept
bindkey '^I' menu-complete
bindkey "$terminfo[kcbt]" reverse-menu-complete
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey '^H' backward-kill-word
bindkey '5~' kill-word
bindkey '^R' history-incremental-search-backward

#  ┌─┐─┐ ┬┌┬┐┬─┐┌─┐┌─┐┌┬┐
#  ├┤ ┌┴┬┘ │ ├┬┘├─┤│   │
#  └─┘┴ └─ ┴ ┴└─┴ ┴└─┘ ┴
#  (extract)
extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1     ;;
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
#   (tmux)
[[ -z "$TMUX" ]] && exec tmux

#  ┬  ┌─┐┌┐┌┌─┐  ┌─┐┌─┐┌┬┐┌┬┐┌─┐┌┐┌┌┬┐┌─┐  ┌┐ ┌─┐┌─┐┌─┐
#  │  │ │││││ ┬  │  │ │││││││├─┤│││ ││└─┐  ├┴┐├┤ ├┤ ├─┘
#  ┴─┘└─┘┘└┘└─┘  └─┘└─┘┴ ┴┴ ┴┴ ┴┘└┘─┴┘└─┘  └─┘└─┘└─┘┴
#  (long commands beep)
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

