export COLORTERM=truecolor

setopt promptsubst

# Plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source /usr/share/nvm/init-nvm.sh 2>/dev/null

# Starship
eval "$(starship init zsh)"

# Zoxide — adds 'z' and 'zi', does NOT replace 'cd'
eval "$(zoxide init zsh)"

# Exports
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$HOME/.local/bin:$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools
export EDITOR="nvim"
export VCPKG_ROOT=$HOME/.local/share/vcpkg
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin:$HOME/.cargo/bin

# ── eza — new names only, 'ls' untouched ────────────────────────────────────
alias ll='eza -la --icons --git --group-directories-first'
alias la='eza -a  --icons --group-directories-first'
alias lt='eza --tree --icons --level=2'
alias l='eza --icons --group-directories-first'

# ── bat — view files with syntax highlight, 'cat' untouched ─────────────────
alias b='bat'
alias bman='batman'

# ── lazygit ──────────────────────────────────────────────────────────────────
alias lg='lazygit'

# ── tealdeer ─────────────────────────────────────────────────────────────────
alias tldr='tldr'

# ── Apps ─────────────────────────────────────────────────────────────────────
alias vscode='code --enable-features=UseOzonePlatform --ozone-platform=wayland'
alias vim='nvim'
