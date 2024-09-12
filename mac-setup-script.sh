#!/bin/bash

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Install Xcode Command Line Tools
if ! xcode-select --print-path >/dev/null 2>&1; then
  echo "Installing Xcode Command Line Tools..."
  xcode-select --install
else
  echo "Xcode Command Line Tools are already installed."
fi

# Install Homebrew
if ! command_exists brew; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew is already installed."
fi

# Update Homebrew and install Node.js & npm
echo "Updating Homebrew..."
brew update

# Install nvm (Node Version Manager)
if [ ! -d "$HOME/.nvm" ]; then
  echo "Installing NVM (Node Version Manager)..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
  # Load NVM into the current shell session
  export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
else
  echo "NVM is already installed."
fi

# Install the latest stable version of Node.js and npm using nvm
echo "Installing the latest stable version of Node.js via NVM..."
nvm install node

# Install Visual Studio Code
if ! command_exists code; then
  echo "Installing Visual Studio Code..."
  brew install --cask visual-studio-code
else
  echo "Visual Studio Code is already installed."
fi

echo "All installations completed."
