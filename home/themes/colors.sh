#!/bin/bash
# Define color variables based on the Catppuccin theme
case $CATPPUCCIN_FLAVOUR in
  "macchiato")
    export COLOR_BACKGROUND="#F2D0D5"  # Background color
    export COLOR_MANTLE="#BBAF92"       # Mantle color (darker background)
    export COLOR_CRUST="#A6D5E0"         # Crust color (darkest)
    export COLOR_ACCENT="#F5C2E7"        # Accent color (highlights)
    ;;
  "frappe")
    export COLOR_BACKGROUND="#D9E9B6"    # Background color
    export COLOR_MANTLE="#7A7D7D"        # Mantle color
    export COLOR_CRUST="#A8C4D9"         # Crust color
    export COLOR_ACCENT="#F2B591"        # Accent color
    ;;
  "latte")
    export COLOR_BACKGROUND="#D5C4A1"    # Background color
    export COLOR_MANTLE="#7C7B7A"        # Mantle color
    export COLOR_CRUST="#B5D4A2"         # Crust color
    export COLOR_ACCENT="#E6B8D3"        # Accent color
    ;;
  "mocha")
    export COLOR_BACKGROUND="#B4D2E4"    # Background color
    export COLOR_MANTLE="#C1C6A5"        # Mantle color
    export COLOR_CRUST="#F4A4B8"          # Crust color
    export COLOR_ACCENT="#A0A9B4"         # Accent color
    ;;
  *)
    echo "Unknown Catppuccin flavor"
    ;;
esac
