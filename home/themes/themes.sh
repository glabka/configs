#!/bin/bash
# Determine if batcat or bat is available
if command -v batcat &> /dev/null; then
    BAT_COMMAND="batcat"
else
    BAT_COMMAND="bat"
fi

# Check if the Catpuccin theme is available
if $BAT_COMMAND --list-themes | grep -q "Catpuccin"; then
    export BAT_THEME="Catppuccin Mocha"
else
    export BAT_THEME="base16"
fi

