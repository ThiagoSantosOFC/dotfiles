export COLORTERM=truecolor

# Enable prompt substitution
setopt promptsubst

# Initialize Starship (this will set the prompt)

# Load plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source /usr/share/nvm/init-nvm.sh 2>/dev/null

# Exports
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$HOME/.local/bin:$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools
export EDITOR="vim"
export VCPKG_ROOT=$HOME/.local/share/vcpkg

# Aliases
alias vscode='code --enable-features=UseOzonePlatform --ozone-platform=wayland'
