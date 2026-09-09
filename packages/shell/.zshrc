# ------- oh-my-zsh main path -------
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/.config/oh-my-zsh/custom"

# ------- Completions setup BEFORE sourcing oh-my-zsh -------
# - Homebrew completions
if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh-completions:$FPATH"
fi
# - zsh-completions (do NOT load it as a plugin, just add its src to fpath)
fpath+=("${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src")

# ------- oh-my-zsh options -------
CASE_SENSITIVE="true"
zstyle ':omz:update' mode disabled
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="dd/mm/yyyy"

# ------- oh-my-zsh plugins -------
plugins=(
  git git-flow
  pnpm yarn npm brew macos vscode
  docker docker-compose multipass globalias
  fzf-tab
  bun
)

# ------- Load oh-my-zsh (this runs compinit once, no need to run it manually) -------
source "$ZSH/oh-my-zsh.sh"

# ------- fzf configuration -------
source <(fzf --zsh)
export FZF_DEFAULT_COMMAND="rg --files --follow --hidden --glob '!.git'"
export FZF_DEFAULT_OPTS="--highlight-line --info=inline-right --ansi --layout=reverse --border=none"
export FZF_CTRL_T_OPTS="--preview='less {}' --height=100% --bind shift-up:preview-page-up,shift-down:preview-page-down"

source ~/.config/zsh/themes/fzf/catppuccin-latte.sh

# ------- fzf-tab styles (optional customization) -------
# Switch between completion groups with , and .
# Disable the classic completion menu.
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':completion:*' menu no
# Ensure colors match by using FZF_DEFAULT_OPTS.
zstyle ":fzf-tab:*" use-fzf-default-opts yes
# Preview file contents when tab completing directories.
zstyle ":fzf-tab:complete:cd:*" fzf-preview "ls --color=always \${realpath}"

# ------- Docker completions tweaks -------
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

# ------- User configuration -------
export ARCHFLAGS="-arch $(uname -m)"

# ------- User binaries -------
case ":$PATH:" in
  *":$HOME/.local/bin:"*) ;;
  *) export PATH="$HOME/.local/bin:$PATH" ;;
esac

# ------- zsh options -------
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Aliases
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias purgeallbuilds='rm -rf ~/Library/Developer/Xcode/DerivedData/*'
alias m='make'; compdef m=make
alias n='nvim'
alias lg='lazygit'
alias cc='claude'
alias awake='caffeinate -ims'
alias awake-4h='caffeinate -dims -t 14400'
alias awake-8h='caffeinate -dims -t 28800'

for file in "$HOME"/.config/shell/aliases/*.zsh(N); do
  [ -r "$file" ] && source "$file"
done

# ------- Node Version Manager (nvm) -------
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# ------- pnpm setup -------
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# ------- Ruby (rbenv) -------
eval "$(rbenv init - zsh)"

# ------- Android SDK -------
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# ------- zsh-autosuggestions -------
# Should be loaded AFTER oh-my-zsh
source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" 2>/dev/null || true
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#9bbdfd"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1

# ------- zsh-vi-mode -------
source "$HOMEBREW_PREFIX/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh" 2>/dev/null || true
# zsh-vi-mode initializes lazily and otherwise replaces fzf's Ctrl-R binding.
zvm_after_init_commands+=( "bindkey -M viins ^R fzf-history-widget" )

# ------- starship prompt terminal -------
eval "$(starship init zsh)"

# ------- zsh-syntax-highlighting -------
# Must be the LAST thing sourced
source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" 2>/dev/null || true

# ------- Go ------
export PATH="$HOME/go/bin:$PATH"

# ------- bun -------
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"

# ------- Worktrunk -------
if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi

# sentry
export PATH="$HOME/.sentry/bin:$PATH"

# Mole shell completion
if output="$(mole completion zsh 2>/dev/null)"; then eval "$output"; fi

[[ -r "$HOME/.config/zsh/local.zsh" ]] && source "$HOME/.config/zsh/local.zsh"

# agent-device
[[ -r "$HOME/.config/agent-device/env.zsh" ]] &&
  source "$HOME/.config/agent-device/env.zsh"

# Secrets

[[ -r "$HOME/.secrets/slides.env" ]] && source "$HOME/.secrets/slides.env"
