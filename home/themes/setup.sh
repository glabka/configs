#!/bin/bash
# $1 - path to git repo with proper files and its subdir themes

# Check the condition for JOB_MACHINE
if [ -z "${JOB_MACHINE}" ] || [ "${JOB_MACHINE}" = "true" ] || { [[ "$JOB_MACHINE" =~ ^[0-9]+$ ]] && [ "$JOB_MACHINE" -eq 1 ]; }; then
    # Your commands here
    echo "Condition met: JOB_MACHINE is either unset, 'true', or 1."

    # Exit the script
    exit 0
fi

# Get the path to the themes directory
THEMES=$(pwd)

# Get the current directory name
CURRENT_DIR_NAME=$(basename "$THEMES")

# Copy themes to the config directory
cp -ar "$THEMES" ~/.config/

# Remove the setup.sh file in the config directory
rm "$HOME/.config/$CURRENT_DIR_NAME/setup.sh"
