
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

export GITHUB_USERNAME="ErwannRousseau" 
export EDITOR="nvim"
export VISUAL="$EDITOR"

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

if [[ -n ${HOMEBREW_PREFIX:-} ]]; then
  export PATH="$HOMEBREW_PREFIX/opt/mysql-client/bin:$PATH"
fi
