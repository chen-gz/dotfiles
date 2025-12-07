#!/bin/bash

# This script automates common setup tasks for a new macOS machine.
# It installs Homebrew, essential command-line tools, and popular applications.

# =============================================================================
# HOW TO USE THIS SCRIPT
# =============================================================================
# Run directly from GitHub Gist:
#   curl -fsSL https://gist.githubusercontent.com/chen-gz/07c59a71d960a6f9584f35c61ae95dd7/raw/mac_setup_script.sh | bash
#
# Or download and run locally:
#   curl -O https://gist.githubusercontent.com/chen-gz/07c59a71d960a6f9584f35c61ae95dd7/raw/mac_setup_script.sh
#   chmod +x setup.sh
#   ./setup.sh
#
# GitHub Gist: https://gist.github.com/chen-gz/07c59a71d960a6f9584f35c61ae95dd7
# =============================================================================

# =============================================================================
# COLOR SCHEME REFERENCE
# =============================================================================
# Red    (\033[31m) - User input required / warnings / errors
# Green  (\033[32m) - Success messages with ✓ checkmarks  
# Yellow (\033[33m) - Warnings / actions needed
# Blue   (\033[34m) - Section headers and informational messages
# Cyan   (\033[36m) - Process/status messages
# Reset  (\033[0m)  - Returns to normal color
# 
# Symbols used:
# ✓ - Success/completion
# ⚠️ - Warning/user input required
# ✗ - Error/failure
# 🎉 - Script completion
# • - Bullet points for lists
# =============================================================================

printf "\033[34m=== Starting Mac Setup Script ===\033[0m\n"

# --- 1. Install Homebrew ---
# Homebrew is a package manager for macOS.
if ! command -v brew &> /dev/null; then
    printf "\033[33mHomebrew not found. Installing Homebrew...\033[0m\n"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    printf "\033[32m✓ Homebrew installed successfully!\033[0m\n"
else
    printf "\033[36mHomebrew is already installed. Updating Homebrew...\033[0m\n"
    brew update
    brew upgrade
fi

printf "\033[34m--- Homebrew installation/update complete ---\033[0m\n"

# --- 2. Install essential command-line tools and applications via Homebrew ---
printf "\033[32mInstalling essential command-line tools and applications...\033[0m\n"
brew install --cask iterm2 # A better terminal emulator
brew install gnupg # GnuPG for encryption and signing
brew install fish # Fish shell
brew install rg fd fzf lazygit treesitter-cli latexindent prettier utftex

# Set Fish as the default shell
if grep -q "$(which fish)" /etc/shells; then
    printf "\033[36mFish shell is already listed in /etc/shells.\033[0m\n"
else
    printf "\033[33mAdding Fish shell to /etc/shells...\033[0m\n"
    # This command requires sudo, so it will prompt for your password.
    echo "$(which fish)" | sudo tee -a /etc/shells
fi

# Check if Fish is already the default shell
if [[ "$SHELL" == "$(which fish)" ]]; then
    printf "\033[36mFish is already set as your default shell.\033[0m\n"
else
    printf "\033[31m⚠️  Setting Fish as the default shell. You will be prompted for your password.\033[0m\n"
    chsh -s "$(which fish)"
    printf "\033[32m✓ Fish is now set as your default shell. Please restart your terminal for changes to take effect.\033[0m\n"
fi


# Install yadm via Homebrew
if ! command -v yadm &> /dev/null; then
    printf "\033[33myadm not found. Installing yadm...\033[0m\n"
    brew install yadm # Install yadm without running tests
    printf "\033[32m✓ yadm installed successfully!\033[0m\n"
    # Clone dotfiles using yadm
    printf "\033[36mCloning dotfiles from github.com/chen-gz/dotfiles using yadm...\033[0m\n"
    yadm clone https://github.com/chen-gz/dotfiles
    printf "\033[32m✓ Dotfiles cloned successfully!\033[0m\n"
else
    printf "\033[36myadm is already installed.\033[0m\n"
    printf "\033[36mAttempting to update dotfiles with yadm pull...\033[0m\n"
    yadm pull
    printf "\033[32m✓ Dotfiles updated (if changes were available).\033[0m\n"
fi


# Homebrew Cask applications
printf "\033[34mInstalling applications via Homebrew Cask...\033[0m\n"
# Browsers
printf "\033[36mInstalling Google Chrome...\033[0m\n"
brew install --cask google-chrome

# Development Tools
printf "\033[36mInstalling Visual Studio Code...\033[0m\n"
brew install --cask visual-studio-code

printf "\033[34m--- Command-line tools and application installation complete ---\033[0m\n"


# --- 3. Configure macOS defaults (Optional) ---
# These are some common macOS preferences you might want to set.
printf "\033[34mSetting up macOS defaults (this might require a restart for some changes)...\033[0m\n"

# Show hidden files in Finder
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show path bar in Finder
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true

# Enable key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false # Disable accent menu to allow key repeat

printf "\033[34m--- macOS defaults configured ---\033[0m\n"

# --- 4. GnuPG Key Management ---
printf "\033[34mFetching and trusting GnuPG key...\033[0m\n"

# Key ID to fetch
GPG_KEY_ID="0x636538d58af1006d" # This is the full key ID from your request

# Fetch the public key from a keyserver (e.g., keys.openpgp.org or hkps.pool.sks-keyservers.net)
# Using --recv-keys is generally preferred over --search for direct key fetching.
gpg --keyserver keys.openpgp.org --recv-keys "$GPG_KEY_ID"

# Check if the key was imported successfully
if gpg --list-keys "$GPG_KEY_ID" &> /dev/null; then
    printf "\033[32m✓ Key $GPG_KEY_ID imported successfully.\033[0m\n"
    
    # Check if key already has ultimate trust
    if gpg --list-keys --with-colons "$GPG_KEY_ID" | grep -q "^pub.*:u:"; then
        printf "\033[36mKey already has ultimate trust, skipping trust setting...\033[0m\n"
    else
        printf "\033[36mSetting trust level for the key automatically...\033[0m\n"
        # Automatically set trust level to ultimate (5) without user interaction
        printf "trust\n5\ny\nquit\n" | gpg --command-fd 0 --edit-key "$GPG_KEY_ID" --batch --no-tty
        printf "\033[32m✓ Trust level for key $GPG_KEY_ID set to ultimate automatically.\033[0m\n"
    fi
else
    printf "\033[31m✗ Failed to import key $GPG_KEY_ID. Please check the key ID or keyserver.\033[0m\n"
fi

# Configure GnuPG agent for SSH
printf "\033[36mConfiguring GnuPG agent for SSH...\033[0m\n"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpg-connect-agent updatestartuptty /bye >/dev/null
printf "\033[32m✓ GnuPG agent configured for SSH authentication.\033[0m\n"

# Update yadm remote to use SSH
printf "\033[36mUpdating yadm remote to use SSH...\033[0m\n"
if command -v yadm &> /dev/null; then
    yadm remote set-url origin git@github.com:chen-gz/dotfiles.git
    printf "\033[32m✓ yadm remote updated to use SSH (git@github.com:chen-gz/dotfiles.git)\033[0m\n"
    
    # Decrypt encrypted dotfiles
    printf "\033[36mDecrypting encrypted dotfiles...\033[0m\n"
    yadm decrypt
    printf "\033[32m✓ Dotfiles decryption completed.\033[0m\n"
else
    printf "\033[33myadm not found, skipping remote URL update and decryption.\033[0m\n"
fi

printf "\033[34m--- GnuPG Key Management complete ---\033[0m\n"


# --- 5. Post-installation steps ---
printf "\033[36mCleaning up Homebrew cache and incomplete installations...\033[0m\n"
# Clean up cache and remove incomplete downloads
brew cleanup --prune=all
# Remove old versions and clean up thoroughly
brew autoremove
printf "\033[32m✓ Homebrew cleanup completed\033[0m\n"

printf "\033[32m🎉 Setup script finished!\033[0m\n"
printf "\033[33mYou might want to:\033[0m\n"
printf "\033[33m  • Log out and log back in to apply all changes.\033[0m\n"
