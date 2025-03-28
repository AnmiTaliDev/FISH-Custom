#!/usr/bin/env fish

# Script metadata
set -g SCRIPT_VERSION "1.0.0"
set -g SCRIPT_DATE "2025-03-28 16:22:36"
set -g SCRIPT_AUTHOR "AnmiTaliDev"

# Constants
set -g FISH_CONFIG_DIR "$HOME/.config/fish"
set -g FISH_CONFIG_BACKUP "$FISH_CONFIG_DIR/config.fish.backup.(date +%Y%m%d_%H%M%S)"
set -g OMF_DIR "$HOME/.local/share/omf"
set -g CUSTOM_DIR "$HOME/.config/fish/custom"
set -g LOG_FILE "/tmp/fish_setup_(date +%Y%m%d_%H%M%S).log"

# Color constants (Fish uses its own color syntax)
set -g RED (set_color red)
set -g GREEN (set_color green)
set -g YELLOW (set_color yellow)
set -g BLUE (set_color blue)
set -g NC (set_color normal)

# Theme options with descriptions
set -g THEME_DESCRIPTIONS
set -a THEME_DESCRIPTIONS "default:The default Fish theme - clean and simple"
set -a THEME_DESCRIPTIONS "agnoster:Powerline-style theme with git integration"
set -a THEME_DESCRIPTIONS "bobthefish:Powerline-style, feature-rich theme"
set -a THEME_DESCRIPTIONS "clearance:Informative and clean theme"
set -a THEME_DESCRIPTIONS "astronaut:Minimalistic theme for space travelers"
set -a THEME_DESCRIPTIONS "sashimi:Clean and compact theme"

# Basic plugins
set -g BASIC_PLUGINS \
    "foreign-env" \
    "fzf" \
    "bang-bang" \
    "done" \
    "bass" \
    "colored-man-pages"

# Logging functions
function log
    echo -e "$GREEN[INFO]$NC $argv" | tee -a "$LOG_FILE"
end

function warn
    echo -e "$YELLOW[WARNING]$NC $argv" | tee -a "$LOG_FILE"
end

function error
    echo -e "$RED[ERROR]$NC $argv" | tee -a "$LOG_FILE" >&2
end

# Display script header
function show_header
    echo "Fish Shell Configuration Script"
    echo "Version: $SCRIPT_VERSION"
    echo "Date: $SCRIPT_DATE"
    echo "Author: $SCRIPT_AUTHOR"
    echo "----------------------------------------"
end

# Select theme function
function select_theme
    echo -e "\n$BLUE""Available themes:$NC\n"
    set -l i 1
    
    for theme_desc in $THEME_DESCRIPTIONS
        set -l theme (string split ":" $theme_desc)[1]
        set -l description (string split ":" $theme_desc)[2]
        printf "$GREEN%2d)$NC %-20s - %s\n" $i $theme $description
        set i (math $i + 1)
    end
    
    while true
        echo -e "\n$YELLOW""Select a theme (1-"(count $THEME_DESCRIPTIONS)"):$NC "
        read -l selection
        
        if test "$selection" -ge 1 -a "$selection" -le (count $THEME_DESCRIPTIONS)
            set -g SELECTED_THEME (string split ":" $THEME_DESCRIPTIONS[$selection])[1]
            break
        else
            error "Invalid selection. Please choose a number between 1 and "(count $THEME_DESCRIPTIONS)
        end
    end
    
    if test "$SELECTED_THEME" = "bobthefish"
        install_bobthefish
    end
    
    log "Selected theme: $SELECTED_THEME"
end

# Select editor function
function select_editor
    echo -e "\n$BLUE""Select your preferred text editor:$NC"
    set -l editors vim nano code nvim emacs custom
    set -l i 1
    
    for editor in $editors
        if test "$editor" = "custom"
            printf "$GREEN%2d)$NC Custom (specify your own)\n" $i
        else
            if command -v $editor >/dev/null
                printf "$GREEN%2d)$NC %s $GREEN(installed)$NC\n" $i $editor
            else
                printf "$GREEN%2d)$NC %s $YELLOW(not installed)$NC\n" $i $editor
            end
        end
        set i (math $i + 1)
    end
    
    while true
        echo -e "\n$YELLOW""Select editor (1-"(count $editors)"):$NC "
        read -l selection
        
        if test "$selection" -ge 1 -a "$selection" -le (count $editors)
            if test "$editors[$selection]" = "custom"
                echo -e "$YELLOW""Enter your preferred editor command:$NC "
                read -l SELECTED_EDITOR
            else
                set -g SELECTED_EDITOR $editors[$selection]
            end
            break
        else
            error "Invalid selection. Please choose a number between 1 and "(count $editors)
        end
    end
    
    log "Selected editor: $SELECTED_EDITOR"
end

# Install bobthefish theme
function install_bobthefish
    log "Installing bobthefish theme..."
    omf install bobthefish
end

# Install Oh My Fish
function install_omf
    if not test -d "$OMF_DIR"
        log "Installing Oh My Fish..."
        curl -L https://get.oh-my.fish | fish
    else
        log "Oh My Fish is already installed"
    end
end

# Install plugins
function install_plugins
    log "Installing plugins..."
    
    for plugin in $BASIC_PLUGINS
        if not omf list | grep -q $plugin
            log "Installing $plugin..."
            omf install $plugin
        else
            log "$plugin is already installed"
        end
    end
    
    # Install Fisher package manager
    if not functions -q fisher
        log "Installing Fisher package manager..."
        curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
    end
    
    # Install additional Fisher packages
    fisher install PatrickF1/fzf.fish
    fisher install franciscolourenco/done
    fisher install edc/bass
end

# Generate Fish configuration
function generate_config
    mkdir -p "$FISH_CONFIG_DIR/functions"
    
    echo '# Fish shell configuration
# Generated by fish_setup.fish
# Date: '$SCRIPT_DATE'
# Author: '$SCRIPT_AUTHOR'

# Theme configuration
set -g theme_color_scheme dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_git yes
set -g theme_display_git_dirty yes
set -g theme_display_git_untracked yes

# Editor configuration
set -gx EDITOR '$SELECTED_EDITOR'

# Path configuration
fish_add_path $HOME/.local/bin

# Basic aliases
alias ls="ls --color=auto"
alias ll="ls -la"
alias l="ls -l"
alias fishconfig="$EDITOR ~/.config/fish/config.fish"

# FZF configuration
set -gx FZF_DEFAULT_OPTS "--height 40% --layout=reverse --border"

# Directory navigation
function cd..
    cd ..
end

# Load custom functions if they exist
for f in $HOME/.config/fish/functions/*.fish
    source $f
end

# Load local configuration if it exists
if test -f ~/.config/fish/local.fish
    source ~/.config/fish/local.fish
end

# Initialize Oh My Fish
source $OMF_DIR/init.fish' > "$FISH_CONFIG_DIR/config.fish"
    
    # Create empty local configuration
    touch "$FISH_CONFIG_DIR/local.fish"
end

# Preview theme function
function preview_theme
    log "Theme preview instructions:"
    echo -e "$YELLOW""To preview how your prompt will look with $GREEN$SELECTED_THEME$YELLOW:$NC"
    echo -e "1. After installation, run: $GREEN""exec fish$NC"
    echo -e "2. Try some commands to see how the prompt reacts"
    echo -e "3. To change the theme later, run: $GREEN""omf theme $SELECTED_THEME$NC"
    
    if test "$SELECTED_THEME" = "bobthefish"
        echo -e "$YELLOW""Note: bobthefish theme works best with a Powerline-compatible font$NC"
    end
end

# Check if running with sudo/root
function check_root
    if test (id -u) = "0"
        error "This script should NOT be run as root or with sudo"
        exit 1
    end
end

# Backup existing config
function backup_existing_config
    if test -f "$FISH_CONFIG_DIR/config.fish"
        log "Creating backup of existing config..."
        if cp "$FISH_CONFIG_DIR/config.fish" "$FISH_CONFIG_BACKUP"
            log "Backup created at $FISH_CONFIG_BACKUP"
        else
            error "Failed to create backup"
            exit 1
        end
    end
end

# Main installation function
function main
    show_header
    log "Starting Fish shell configuration setup..."
    log "Log file: $LOG_FILE"
    
    check_root
    backup_existing_config
    install_omf
    select_theme
    select_editor
    install_plugins
    
    log "Generating new Fish configuration..."
    generate_config
    
    preview_theme
    
    log "Configuration complete!"
    echo -e "\n$GREEN""Installation completed successfully!$NC"
    echo -e "\n$YELLOW""To apply the new configuration:$NC"
    echo -e "1. Run: $GREEN""exec fish$NC"
    echo -e "2. For additional customizations, edit: $GREEN""~/.config/fish/local.fish$NC"
end

# Run main function
main $argv