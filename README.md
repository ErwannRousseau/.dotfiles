# Install 

```bash
brew install chezmoi
```

```bash
chezmoi init --apply https://github.com/ErwannRousseau/.dotfiles.git
```

# Script to run 

```bash
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
```

```bash
chmod go-w "$(brew --prefix)/share"
chmod -R go-w "$(brew --prefix)/share/zsh"
```

