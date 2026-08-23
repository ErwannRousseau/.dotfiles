
eval "$(/opt/homebrew/bin/brew shellenv)"

export GITHUB_USERNAME="ErwannRousseau" 
export EDITOR="nvim"
export VISUAL="$EDITOR"

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
