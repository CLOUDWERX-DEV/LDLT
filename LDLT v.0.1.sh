#!/bin/bash

# LDLT: Linux Dev Launcher Tool
# A tool to streamline your development environment in Linux
# Install Cursor Properly to PATH, Icon System-Wide, Add Dev 
# Launch Actions to Nemo Context Menu & Launch a Nuke!!
# Version: 0.1
# Author: Cloudwerx.dev
# Website: http://cloudwerx.dev | http://github.com/CLOUDWERX-DEV
# Date: 2025-03-13

# Colors and formatting
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
BOLD='\033[1m'
DIM='\033[2m'
UNDERLINE='\033[4m'
BLINK='\033[5m'
REVERSE='\033[7m'
HIDDEN='\033[8m'
RESET='\033[0m'

# Color gradient for logo
C1='\033[38;5;33m'  # Light blue
C2='\033[38;5;39m'  # Blue
C3='\033[38;5;45m'  # Cyan
C4='\033[38;5;51m'  # Light cyan
C5='\033[38;5;87m'  # Very light blue

# Function to display the entire UI with a smooth reveal
display_intro() {
    clear
    
    # First display the logo line by line with a short delay
    echo
    sleep 0.05
    echo -e "${C1}    ██╗     ${C2}██████╗ ${C3}██╗     ${C4}████████╗"
    sleep 0.05
    echo -e "${C1}    ██║     ${C2}██╔══██╗${C3}██║     ${C4}╚══██╔══╝"
    sleep 0.05
    echo -e "${C1}    ██║     ${C2}██║  ██║${C3}██║        ${C4}██║   "
    sleep 0.05
    echo -e "${C1}    ██║     ${C2}██║  ██║${C3}██║        ${C4}██║   "
    sleep 0.05
    echo -e "${C1}    ███████╗${C2}██████╔╝${C3}███████╗   ${C4}██║   "
    sleep 0.05
    echo -e "${C1}    ╚══════╝${C2}╚═════╝ ${C3}╚══════╝   ${C4}╚═╝   "
    echo
    
    # Then show the box frame
    sleep 0.1
    echo -e "${C5}${BOLD}  ╔════════════════════════════════════════╗${RESET}"
    echo -e "${C5}${BOLD}  ║${RESET}${CYAN}      Linux Dev Launcher Tool v1.0      ${C5}${BOLD}║${RESET}"
    echo -e "${C5}${BOLD}  ╚════════════════════════════════════════╝${RESET}"
    echo -e "${C5}${BOLD}            http://cloudwerx.dev${RESET}"
    echo
    
    # Display gradient tagline
    sleep 0.1
    echo -e "  ${C1}Streamline ${C2}your ${C3}development ${C4}environment ${C5}in Linux"
    echo
    sleep 0.1
    echo -e "  ${C1}Install ${C2}Cursor ${C3}Properly ${C4}!! ${C5}💥"
    echo
}

# Function to display the main menu with enhanced visuals
display_menu() {
    echo -e "${YELLOW}${BOLD}╭─── Choose an option ───╮${RESET}"
    echo
    echo -e "  ${MAGENTA}${BOLD}1)${RESET} ${CYAN}Install Cursor AppImage to PATH${RESET}"
    echo -e "  ${MAGENTA}${BOLD}2)${RESET} ${CYAN}Install Cursor Icon System-Wide${RESET}"
    echo -e "  ${MAGENTA}${BOLD}3)${RESET} ${CYAN}Add Dev Launch Actions to Nemo Context Menu${RESET}"
    echo -e "  ${MAGENTA}${BOLD}4)${RESET} ${RED}Launch a Nuke${RESET} ${BLINK}💥${RESET}"
    echo -e "  ${MAGENTA}${BOLD}5)${RESET} ${GREEN}Do It All!${RESET} ${BOLD}🚀${RESET}"
    echo -e "  ${MAGENTA}${BOLD}q)${RESET} ${DIM}Quit${RESET}"
    echo
    echo -e "${YELLOW}${BOLD}╰─────────────────────╯${RESET}"
    echo
    echo -n -e "${YELLOW}Enter your choice [1-5 or q]: ${RESET}"
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install Cursor AppImage to PATH
install_cursor_appimage() {
    clear
    echo -e "${BLUE}${BOLD}╭─── Installing Cursor AppImage to PATH ───╮${RESET}"
    echo
    
    # Check if cursor is already installed
    if command_exists cursor; then
        echo -e "${YELLOW}Cursor command already exists in PATH.${RESET}"
        echo -e "${YELLOW}Do you want to update it? [y/N]: ${RESET}"
        read update_cursor
        if [[ ! "$update_cursor" =~ ^[Yy]$ ]]; then
            echo -e "${YELLOW}Skipping Cursor installation.${RESET}"
            sleep 1
            return 0
        fi
    fi
    
    # Ask for sudo password
    echo -e "${YELLOW}This step requires sudo access to install to /usr/local/bin${RESET}"
    sudo -v
    
    if [ $? -ne 0 ]; then
        echo -e "${RED}${BOLD}Error:${RESET} ${RED}Failed to obtain sudo privileges. Aborting.${RESET}"
        return 1
    fi
    
    # Ask for the AppImage path
    echo -e "${YELLOW}Enter the full path to your Cursor AppImage:${RESET}"
    read -e CURSOR_PATH
    
    # Confirm the path
    echo
    echo -e "${CYAN}You entered: ${WHITE}${UNDERLINE}$CURSOR_PATH${RESET}"
    echo -e "${YELLOW}Is this correct? [y/N]: ${RESET}"
    read confirm
    
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        echo -e "${RED}Operation cancelled.${RESET}"
        return 1
    fi
    
    # Check if the file exists
    if [ ! -f "$CURSOR_PATH" ]; then
        echo -e "${RED}${BOLD}Error:${RESET} ${RED}File not found. Please check the path and try again.${RESET}"
        return 1
    fi
    
    # Verify it's an AppImage
    if ! file "$CURSOR_PATH" | grep -q "executable"; then
        echo -e "${RED}${BOLD}Warning:${RESET} ${RED}The file doesn't appear to be an executable. Continue anyway? [y/N]: ${RESET}"
        read continue_anyway
        if [[ ! "$continue_anyway" =~ ^[Yy]$ ]]; then
            echo -e "${RED}Operation cancelled.${RESET}"
            return 1
        fi
    fi
    
    # Make the AppImage executable
    echo -e "${CYAN}Making AppImage executable...${RESET}"
    chmod +x "$CURSOR_PATH"
    
    # Create the wrapper script
    echo -e "${CYAN}Creating launcher script in /usr/local/bin...${RESET}"
    echo -e '#!/bin/bash\n"'"$CURSOR_PATH"'" --no-sandbox "$@" > /dev/null 2>&1 &\ndisown' | sudo tee /usr/local/bin/cursor > /dev/null
    sudo chmod +x /usr/local/bin/cursor
    
    # Check if successful
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}${BOLD}✓ Cursor successfully installed!${RESET}"
        echo
        echo -e "${CYAN}${BOLD}You can now launch Cursor from anywhere using:${RESET}"
        echo -e "${WHITE}  cursor${RESET}"
        echo
        echo -e "${CYAN}${BOLD}Example commands:${RESET}"
        echo -e "${WHITE}  cursor .${RESET}             ${YELLOW}# Open Cursor in current directory${RESET}"
        echo -e "${WHITE}  cursor file.js${RESET}       ${YELLOW}# Open specific file in Cursor${RESET}"
        echo -e "${WHITE}  cursor dir1 dir2${RESET}     ${YELLOW}# Open multiple directories${RESET}"
        
        # Offer integration options
        echo
        echo -e "${YELLOW}Would you like to integrate Cursor with your desktop? ${RESET}"
        echo -e "${CYAN}1) Add to application launcher only${RESET}"
        echo -e "${CYAN}2) Add to application launcher and create desktop shortcut${RESET}"
        echo -e "${CYAN}3) Don't integrate${RESET}"
        echo
        echo -n -e "${YELLOW}Your choice [1-3]: ${RESET}"
        read integration_choice
        
        case $integration_choice in
            1|2)
                echo -e "${CYAN}Adding Cursor to application launcher...${RESET}"
                
                # Create desktop entry with updated parameters
                echo -e '[Desktop Entry]\nName=Cursor\nComment=AI-first code editor\nExec=/usr/local/bin/cursor --no-sandbox %U\nIcon=cursor\nType=Application\nCategories=Development;IDE;\nMimeType=text/plain;inode/directory;' | sudo tee /usr/share/applications/cursor.desktop > /dev/null
                sudo update-desktop-database
                
                # Create desktop shortcut if requested
                if [ "$integration_choice" = "2" ]; then
                    echo -e "${CYAN}Creating desktop shortcut...${RESET}"
                    cp /usr/share/applications/cursor.desktop ~/Desktop/
                    chmod +x ~/Desktop/cursor.desktop
                    echo -e "${GREEN}${BOLD}✓ Cursor added to application launcher and desktop shortcut created!${RESET}"
                else
                    echo -e "${GREEN}${BOLD}✓ Cursor added to application launcher!${RESET}"
                fi
                ;;
            *)
                echo -e "${YELLOW}Skipping desktop integration.${RESET}"
                ;;
        esac
    else
        echo -e "${RED}Failed to install Cursor. Please check permissions and try again.${RESET}"
        return 1
    fi
    
    echo
    echo -e "${YELLOW}Press any key to continue...${RESET}"
    read -n 1
    return 0
}

# Function to install Cursor icon system-wide
install_cursor_icon() {
    clear
    echo -e "${BLUE}${BOLD}╭─── Installing Cursor Icon System-Wide ───╮${RESET}"
    echo
    
    echo -e "${CYAN}Unlike traditional package installations, AppImages don't register system icons${RESET}"
    echo -e "${CYAN}automatically. This step will install the Cursor icon system-wide to ensure${RESET}"
    echo -e "${CYAN}proper visual integration with your desktop environment and context menus.${RESET}"
    echo
    
    # Check if icon already exists
    if [ -f "/usr/share/icons/hicolor/scalable/apps/cursor.png" ] || [ -f "/usr/share/pixmaps/cursor.png" ]; then
        echo -e "${YELLOW}Cursor icon already appears to be installed.${RESET}"
        echo -e "${YELLOW}Do you want to reinstall it? [y/N]: ${RESET}"
        read reinstall_icon
        if [[ ! "$reinstall_icon" =~ ^[Yy]$ ]]; then
            echo -e "${YELLOW}Skipping icon installation.${RESET}"
            sleep 1
            return 0
        fi
    fi
    
    # Ask for sudo password
    echo -e "${YELLOW}This step requires sudo access to install system icons${RESET}"
    sudo -v
    
    if [ $? -ne 0 ]; then
        echo -e "${RED}${BOLD}Error:${RESET} ${RED}Failed to obtain sudo privileges. Aborting.${RESET}"
        return 1
    fi
    
    # Create temporary file for the icon
    TEMP_ICON="/tmp/cursor_icon.png"
    
    # Create system icon directories
    echo -e "${CYAN}Creating system icon directories...${RESET}"
    sudo mkdir -p /usr/share/icons/hicolor/scalable/apps/
    sudo mkdir -p /usr/share/pixmaps/
    
    # Base64 encoded icon data (placeholder - do not include actual data in script)
    echo -e "${CYAN}Decoding icon data...${RESET}"
    echo "iVBORw0KGgoAAAANSUhEUgAAAu4AAALuCAYAAADxHZPKAAAAIGNIUk0AAHomAACAhAAA+gAAAIDoAAB1MAAA6mAAADqYAAAXcJy6UTwAAAAGYktHRAD/AP8A/6C9p5MAAIAASURBVHja7P1ncyRZnh56Pq5CR0AnMoGUQKXWVZXVXVUtpqdn2E0O7x0OyeVexb2zd3ev2b17d7/C3Y9Ao/EFX5BmfEGjkbQZznT3cKZ1d6mpqumszCyRlZVZqQUygYQIyBCu9oXjOE443EMDEYF4fmYwiFAeAhGPH/+f/1EURUErXNdt6fJERERERFSb2ukNICIiIiKi2hjciYiIiIh6AIM7EREREVEPYHAnIiIiIuoBDO5ERERERD2AwZ2IiIiIqAcwuBMRERER9QAGdyIiIiKiHsDgTkRERETUAxjciYiIiIh6AIM7EREREVEPYHAnIiIiIuoBDO5ERERERD2AwZ2IiIiIqAcwuBMRERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERHRXqZ0egOI+gz/54hor3E7vQFEREREREREXYOjf0Rb6vl/UKr8rtR5uVq3o2BrBKvZ/9Hg5dwWrouIul/Y/3izI+Hy+0+t63Ajfm7kfPVsJ0f1iQDond4Aoh1WK6zW+6EjX58G73/HABDb/DKkvxmb55HPpwNQpZ/F75r0s/hdkS6vbv4uf5e3VT6P+LsiXY+83SoY3on2IheAg+3vZzYqA704n735u/i7E7gOcR5buh5n88uSfrc2v0zpd1M6j735uymdVt78ks/XaChv5H2daE/hhzj1IxFsRcCOS1+69BUDkACQ3DxNhPL4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94i7+3wFcdlUFNxlo6v2Hq/3n74NzzaAu8O6u8wmwv1BPYx/aLch2953yHN+peAedl3H/Zy957nvR0Q2FvcIs/s8G8a959nzg4K7O6CXXJe7z/eGd2+Zizu4u0tfbIh3X6/efuiN/r8usm7oQ1xkUS1/D5VKWkJLuE3Q9esta/Gu3OfXvkx/7yIbVy1/9/UE2qDyGb/rVTrtd36tt6n3OiIiIiIiIiJrTyNwIqtLf3MistFoNFxERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERETWs/8fzxE8lEcs8HIAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjUtMDMtMTJUMTY6MTU6MjUrMDA6MDDuFftOAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDI1LTAzLTEyVDE2OjE1OjI1KzAwOjAwn0hD8gAAACh0RVh0ZGF0ZTp0aW1lc3RhbXAAMjAyNS0wMy0xMlQxNjoxNToyNSswMDowMMhdYi0AAAAASUVORK5CYII=" | base64 -d > "$TEMP_ICON"
    
    if [ $? -ne 0 ] || [ ! -s "$TEMP_ICON" ]; then
        echo -e "${RED}${BOLD}Error:${RESET} ${RED}Failed to decode icon data. Icon may be corrupted.${RESET}"
        rm -f "$TEMP_ICON"
        return 1
    fi
    
    # Copy the icon to system locations
    echo -e "${CYAN}Installing icon system-wide...${RESET}"
    sudo cp "$TEMP_ICON" /usr/share/icons/hicolor/scalable/apps/cursor.png
    sudo cp "$TEMP_ICON" /usr/share/pixmaps/cursor.png
    
    # Set proper permissions
    sudo chmod 644 /usr/share/icons/hicolor/scalable/apps/cursor.png
    sudo chmod 644 /usr/share/pixmaps/cursor.png
    
    # Update the icon cache
    echo -e "${CYAN}Updating icon cache...${RESET}"
    sudo gtk-update-icon-cache -f /usr/share/icons/hicolor/ 2>/dev/null
    
    # Cleanup
    rm -f "$TEMP_ICON"
    
    # Confirm success
    if [ -f "/usr/share/icons/hicolor/scalable/apps/cursor.png" ]; then
        echo -e "${GREEN}${BOLD}✓ Cursor icon successfully installed system-wide${RESET}"
        echo -e "${CYAN}The icon is now available for desktop shortcuts and Nemo actions${RESET}"
    else
        echo -e "${RED}Failed to install Cursor icon. Please check permissions and try again.${RESET}"
        return 1
    fi
    
    echo
    echo -e "${YELLOW}Press any key to continue...${RESET}"
    read -n 1
    return 0
}

# Function to add Dev Launch Actions to Nemo
install_nemo_actions() {
    clear
    echo -e "${BLUE}${BOLD}╭─── Adding Dev Launch Actions to Nemo Context Menu ───╮${RESET}"
    echo
    
    # Check if Nemo is installed
    if ! command_exists nemo; then
        echo -e "${RED}${BOLD}Error:${RESET} ${RED}Nemo file manager not found. These actions are for Nemo only.${RESET}"
        echo -e "${YELLOW}Press any key to return to the menu...${RESET}"
        read -n 1
        return 1
    fi
    
    # Set directory for Nemo actions
    NEMO_ACTIONS_DIR="$HOME/.local/share/nemo/actions"
    
    # Create directory if it doesn't exist
    if [ ! -d "$NEMO_ACTIONS_DIR" ]; then
        echo -e "${CYAN}Creating Nemo actions directory...${RESET}"
        mkdir -p "$NEMO_ACTIONS_DIR"
    fi
    
    # Function to create a Nemo action file
    create_action() {
        local name="$1"
        local cmd="$2"
        local icon="$3"
        local filename="$NEMO_ACTIONS_DIR/open_in_${cmd}.nemo_action"
        
        # Check if action already exists
        if [ -f "$filename" ]; then
            echo -e "${YELLOW}Action for $name already exists. Overwriting...${RESET}"
        fi
        
        echo -e "${CYAN}Creating action for ${BOLD}$name${RESET}..."
        
        cat > "$filename" << EOF
[Nemo Action]
Name=Open in $name
Comment=Open in $name
Exec=$cmd "%F"
Icon-Name=$icon
Selection=Any
Extensions=any;
EscapeSpaces=true
EOF
        
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✓ Successfully created $name launcher!${RESET}"
        else
            echo -e "${RED}✗ Failed to create $name launcher${RESET}"
        fi
    }
    
    # Display submenu for selecting actions
    echo -e "${YELLOW}${BOLD}╭─── Choose which editor actions to install ───╮${RESET}"
    echo
    echo -e "  ${MAGENTA}${BOLD}1)${RESET} ${CYAN}VSCode${RESET}"
    echo -e "  ${MAGENTA}${BOLD}2)${RESET} ${CYAN}VSCode Insiders${RESET}"
    echo -e "  ${MAGENTA}${BOLD}3)${RESET} ${CYAN}Cursor${RESET}"
    echo -e "  ${MAGENTA}${BOLD}4)${RESET} ${CYAN}Windsurf${RESET}"
    echo -e "  ${MAGENTA}${BOLD}5)${RESET} ${GREEN}Install All${RESET}"
    echo -e "  ${MAGENTA}${BOLD}0)${RESET} ${DIM}Return to Main Menu${RESET}"
    echo
    echo -e "${YELLOW}${BOLD}╰─────────────────────────────────────╯${RESET}"
    echo
    
    # Track which actions have been installed
    vscode_installed=false
    insiders_installed=false
    cursor_installed=false
    windsurf_installed=false
    
    while true; do
        echo -n -e "${YELLOW}Enter your choice [0-5]: ${RESET}"
        read action_choice
        
        case $action_choice in
            1)
                if ! command_exists code; then
                    echo -e "${YELLOW}Warning: VSCode command 'code' not found in PATH.${RESET}"
                    echo -e "${YELLOW}Create the action anyway? [y/N]: ${RESET}"
                    read create_anyway
                    if [[ ! "$create_anyway" =~ ^[Yy]$ ]]; then
                        continue
                    fi
                fi
                create_action "VSCode" "code" "visual-studio-code"
                vscode_installed=true
                ;;
            2)
                if ! command_exists code-insiders; then
                    echo -e "${YELLOW}Warning: VSCode Insiders command 'code-insiders' not found in PATH.${RESET}"
                    echo -e "${YELLOW}Create the action anyway? [y/N]: ${RESET}"
                    read create_anyway
                    if [[ ! "$create_anyway" =~ ^[Yy]$ ]]; then
                        continue
                    fi
                fi
                create_action "VSCode Insiders" "code-insiders" "visual-studio-code-insiders"
                insiders_installed=true
                ;;
            3)
                if ! command_exists cursor; then
                    echo -e "${YELLOW}Warning: Cursor command 'cursor' not found in PATH.${RESET}"
                    echo -e "${YELLOW}Create the action anyway? [y/N]: ${RESET}"
                    read create_anyway
                    if [[ ! "$create_anyway" =~ ^[Yy]$ ]]; then
                        continue
                    fi
                fi
                create_action "Cursor" "cursor" "cursor"
                cursor_installed=true
                ;;
            4)
                if ! command_exists windsurf; then
                    echo -e "${YELLOW}Warning: Windsurf command 'windsurf' not found in PATH.${RESET}"
                    echo -e "${YELLOW}Create the action anyway? [y/N]: ${RESET}"
                    read create_anyway
                    if [[ ! "$create_anyway" =~ ^[Yy]$ ]]; then
                        continue
                    fi
                fi
                create_action "Windsurf" "windsurf" "windsurf"
                windsurf_installed=true
                ;;
            5)
                echo -e "${CYAN}Installing all editor actions...${RESET}"
                
                # Install VSCode action with check
                if ! command_exists code; then
                    echo -e "${YELLOW}Warning: VSCode command 'code' not found in PATH. Creating action anyway.${RESET}"
                fi
                create_action "VSCode" "code" "visual-studio-code"
                vscode_installed=true
                
                # Install VSCode Insiders action with check
                if ! command_exists code-insiders; then
                    echo -e "${YELLOW}Warning: VSCode Insiders command 'code-insiders' not found in PATH. Creating action anyway.${RESET}"
                fi
                create_action "VSCode Insiders" "code-insiders" "visual-studio-code-insiders"
                insiders_installed=true
                
                # Install Cursor action with check
                if ! command_exists cursor; then
                    echo -e "${YELLOW}Warning: Cursor command 'cursor' not found in PATH. Creating action anyway.${RESET}"
                fi
                create_action "Cursor" "cursor" "cursor"
                cursor_installed=true
                
                # Install Windsurf action with check
                if ! command_exists windsurf; then
                    echo -e "${YELLOW}Warning: Windsurf command 'windsurf' not found in PATH. Creating action anyway.${RESET}"
                fi
                create_action "Windsurf" "windsurf" "windsurf"
                windsurf_installed=true
                
                break
                ;;
            0)
                break
                ;;
            *)
                echo -e "${RED}Invalid option. Please try again.${RESET}"
                ;;
        esac
        
        # Ask if they want to install more
        if [ "$action_choice" != "0" ] && [ "$action_choice" != "5" ]; then
            echo
            echo -e "${YELLOW}Install another action? [Y/n]: ${RESET}"
            read another
            if [[ "$another" =~ ^[Nn]$ ]]; then
                break
            fi
        fi
    done
    
    # Only restart Nemo if at least one action was installed
    if $vscode_installed || $insiders_installed || $cursor_installed || $windsurf_installed; then
        echo
        echo -e "${GREEN}${BOLD}✓ Nemo actions installed successfully!${RESET}"
        echo -e "${YELLOW}Restarting Nemo for changes to take effect...${RESET}"
        nemo -q &>/dev/null
        
        echo
        echo -e "${CYAN}You can now right-click on files and folders to open them in your preferred editor.${RESET}"
    else
        echo
        echo -e "${YELLOW}No actions were installed.${RESET}"
    fi
    
    echo
    echo -e "${YELLOW}Press any key to continue...${RESET}"
    read -n 1
    return 0
}

# Function to launch the nuke animation
launch_nuke() {
    clear
    echo -e "${RED}${BOLD}"
    echo "  ⚠️  WARNING: NUCLEAR LAUNCH DETECTED  ⚠️"
    echo -e "${RESET}"
    echo -e "${YELLOW}Are you sure you want to launch a nuke? [y/N]: ${RESET}"
    read confirm
    
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        echo -e "${GREEN}Nuclear launch aborted. That was close!${RESET}"
        sleep 2
        return 0
    fi
    
    # Countdown
    clear
    for i in {10..1}; do
        echo -e "${RED}${BOLD}"
        echo "  ⚠️  NUCLEAR LAUNCH IN PROGRESS  ⚠️"
        echo -e "${RESET}"
        echo -e "${YELLOW}${BOLD}Countdown: $i${RESET}"
        sleep 0.5
        clear
    done
    
    # Explosion animation with rainbow colors
    colors=("${RED}" "${YELLOW}" "${GREEN}" "${CYAN}" "${BLUE}" "${MAGENTA}")
    
    clear
    echo -e "${RED}${BOLD}"
    echo "    ____________________"
    echo "   /                    \\"
    echo "  /                      \\"
    echo " |   DETONATION SEQUENCE  |"
    echo " |        INITIATED       |"
    echo "  \\                      /"
    echo "   \\____________________/"
    echo -e "${RESET}"
    sleep 1
        
    for i in {1..3}; do
        for ((j=0; j<6; j++)); do
            color=${colors[$j]}
            clear
            echo -e "${color}${BOLD}"
            echo "    ____    ____    ____    ____    "
            echo "   /    \\  /    \\  /    \\  /    \\   "
            echo "  /      \\/      \\/      \\/      \\  "
            echo " /                                \\ "
            echo "/                                  \\"
            echo "\\                                  /"
            echo " \\                                / "
            echo "  \\      /\\      /\\      /\\      /  "
            echo "   \\____/  \\____/  \\____/  \\____/   "
            echo -e "${RESET}"
            sleep 0.07
        done
    done
    
    clear
    echo -e "${RED}${BOLD}"
    echo "  _______   _______   _______  "
    echo " |  BOOM  | |  BOOM  | |  BOOM  | "
    echo " |_______| |_______| |_______| "
    echo -e "${RESET}"
    sleep 0.3
    
    clear
    echo -e "${MAGENTA}${BOLD}"
    echo "   ______    ______    ______  "
    echo "  / BOOM \\  / BOOM \\  / BOOM \\ "
    echo " | B  O  O  M  !  B  O  O  M  |"
    echo " |  BOOM  |  BOOM  |  BOOM  | "
    echo "  \\_______/\\_______/\\_______/ "
    echo -e "${RESET}"
    sleep 0.3
    
    # Final explosion with rainbow effect
    for ((i=0; i<3; i++)); do
        for ((j=0; j<6; j++)); do
            color=${colors[$j]}
            clear
            echo -e "${color}${BOLD}"
            echo "             ,@@@@@@@@@@@@,"
            echo "          ,@@@@@@@@@@@@@@@@@,"
            echo "        ,@@@@@@@@@@@@@@@@@@@@,"
            echo "      ,@@@@@@@@@@@@@@@@@@@@@@@@,"
            echo "     @@@@@@@@@@@@@@@@@@@@@@@@@@@@,"
            echo "    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@,"
            echo "   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@,"
            echo "  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@,"
            echo " @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@,"
            echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@,"
            echo " @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@,"
            echo "  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@,"
            echo "   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@,"
            echo "    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@,"
            echo "     @@@@@@@@@@@@@@@@@@@@@@@@@@@@,"
            echo "      '@@@@@@@@@@@@@@@@@@@@@@@@',"
            echo "        '@@@@@@@@@@@@@@@@@@@@',"
            echo "          '@@@@@@@@@@@@@@@@',"
            echo "             '@@@@@@@@@@',"
            echo -e "${RESET}"
            sleep 0.1
        done
    done

        # Final explosion with rainbow effect
    for ((i=0; i<3; i++)); do
        for ((j=0; j<6; j++)); do
            color=${colors[$j]}
            clear
            echo -e "${color}${BOLD}"
            echo "             ,@@@@@@@@@@@@,"
            echo "          ,@@@@@@@@@@@@@@@@@,"
            echo "        ,@@@@@@@@@@@@@@@@@@@@,"
            echo "      ,@@@@@@@@@@@@@@@@@@@@@@@@,"
            echo "     ,@@@@@@@@@@@@@@@@@@@@@@@@@@,"
            echo "    ,@@@@@@@@@@@@@@@@@@@@@@@@@@@@,"
            echo "    ,@@@@@@@@@@@@@@@@@@@@@@@@@@@@@,"
            echo "  ,@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@,"
            echo " ,@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@,"
            echo " ,@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@,"
            echo "   ,@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@,"
            echo "          ,@@@@@@@@@@@@@@@,"
            echo "              ,@@@@@@@@,"
            echo "              ,@@@@@@@@,"
            echo "               ,@@@@@@,"
            echo "                '@@@@',"
            echo "                 '@@',"
            echo "                 '@@',"
            echo "                '@@@@',"
            echo -e "${RESET}"
            sleep 0.1
        done
    done
    
    echo -e "${GREEN}${BOLD}"
    echo "    Mission Accomplished!"
    echo "    You've been thoroughly nuked! + SLAPPED WITH A TROUT! <>< 💥"
    echo -e "${RESET}"
    
    echo
    echo -e "${YELLOW}Press any key to return to the menu...${RESET}"
    read -n 1
    return 0
}

# Function to do it all
do_it_all() {
    clear
    echo -e "${BLUE}${BOLD}╭─── Complete Installation ───╮${RESET}"
    echo
    echo -e "${CYAN}This will perform all installation steps:${RESET}"
    echo -e "${CYAN}1. Install Cursor AppImage to PATH${RESET}"
    echo -e "${CYAN}2. Install Cursor Icon System-Wide${RESET}"
    echo -e "${CYAN}3. Add Dev Launch Actions to Nemo Context Menu${RESET}"
    echo
    echo -e "${YELLOW}Proceed with complete installation? [y/N]: ${RESET}"
    read confirm
    
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        echo -e "${RED}Operation cancelled.${RESET}"
        sleep 1
        return 1
    fi
    
    # Install Cursor to PATH
    echo -e "${YELLOW}${BOLD}Step 1: Installing Cursor AppImage to PATH${RESET}"
    install_cursor_appimage
    
    # Install Cursor icon
    echo -e "${YELLOW}${BOLD}Step 2: Installing Cursor Icon System-Wide${RESET}"
    install_cursor_icon
    
    # For "Do It All", install all Nemo actions without asking
    echo -e "${YELLOW}${BOLD}Step 3: Adding Dev Launch Actions to Nemo${RESET}"
    
    # Check if Nemo is installed
    if ! command_exists nemo; then
        echo -e "${RED}${BOLD}Error:${RESET} ${RED}Nemo file manager not found. Skipping Nemo actions.${RESET}"
        sleep 2
    else
        # Set directory for Nemo actions
        NEMO_ACTIONS_DIR="$HOME/.local/share/nemo/actions"
        
        # Create directory if it doesn't exist
        if [ ! -d "$NEMO_ACTIONS_DIR" ]; then
            echo -e "${CYAN}Creating Nemo actions directory...${RESET}"
            mkdir -p "$NEMO_ACTIONS_DIR"
        fi
        
        # Create all the actions automatically
        echo -e "${CYAN}Installing all editor actions...${RESET}"
        
        # Function to create a Nemo action file (local version for do_it_all)
        local_create_action() {
            local name="$1"
            local cmd="$2"
            local icon="$3"
            local filename="$NEMO_ACTIONS_DIR/open_in_${cmd}.nemo_action"
            
            # Check if editor command exists
            if ! command_exists "$cmd"; then
                echo -e "${YELLOW}Warning: Command '$cmd' not found in PATH. Creating action anyway.${RESET}"
            fi
            
            echo -e "${CYAN}Creating action for ${BOLD}$name${RESET}..."
            
            cat > "$filename" << EOF
[Nemo Action]
Name=Open in $name
Comment=Open in $name
Exec=$cmd "%F"
Icon-Name=$icon
Selection=Any
Extensions=any;
EscapeSpaces=true
EOF
            
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}✓ Successfully created $name launcher!${RESET}"
            else
                echo -e "${RED}✗ Failed to create $name launcher${RESET}"
            fi
        }
        
        local_create_action "VSCode" "code" "visual-studio-code"
        local_create_action "VSCode Insiders" "code-insiders" "visual-studio-code-insiders"
        local_create_action "Cursor" "cursor" "cursor"
        local_create_action "Windsurf" "windsurf" "windsurf"
        
        echo -e "${GREEN}${BOLD}✓ Nemo actions installed successfully!${RESET}"
        echo -e "${YELLOW}Restarting Nemo for changes to take effect...${RESET}"
        nemo -q &>/dev/null
    fi
    
    # Show completion message
    clear
    echo -e "${GREEN}${BOLD}🎉 All installations completed successfully! 🎉${RESET}"
    echo
    echo -e "${CYAN}Your development environment is now fully set up:${RESET}"
    echo -e "${CYAN}✓ Cursor can be launched from terminal with '${WHITE}cursor${CYAN}'${RESET}"
    echo -e "${CYAN}✓ Cursor icon is properly installed system-wide${RESET}"
    echo -e "${CYAN}✓ Right-click context menu actions are configured${RESET}"
    echo
    echo -e "${YELLOW}Let's celebrate with a nuke!${RESET}"
    sleep 2
    
    # Launch the nuke
    launch_nuke
    
    return 0
}

# Main program
main() {
    # Display the introduction animation once
    display_intro
    
    while true; do
        display_menu
        read -n 1 choice
        echo
        
        case $choice in
            1) install_cursor_appimage ;;
            2) install_cursor_icon ;;
            3) install_nemo_actions ;;
            4) launch_nuke ;;
            5) do_it_all ;;
            q|Q) 
                echo -e "${GREEN}${BOLD}Thank you for using LDLT! Goodbye!${RESET}"
		echo -e "${BLUE}${BOLD}Visit CLOUDWERX LAB http://cloudwerx.dev | http://github.com/CLOUDWERX-DEV ${RESET}"
		echo -e "${WHITE}${BOLD}For more tasty digital treats!${RESET}"
		echo -e "${WHITE}${BOLD}BYE BYE !!!${RESET}"
                exit 0
                ;;
            *)
                echo -e "${RED}Invalid option. Please try again.${RESET}"
                sleep 1
                ;;
        esac
    done
}

# Run the main program
main
