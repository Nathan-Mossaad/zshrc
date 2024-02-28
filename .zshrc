# Load p10k configs
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load Zinit
source ~/.zinit/bin/zinit.zsh


# Load standard scripts & p10k with zinit
zinit snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/command-not-found/command-not-found.plugin.zsh
zinit ice wait'!0'; zinit load zsh-users/zsh-syntax-highlighting
zinit ice wait'!0'; zinit load zsh-users/zsh-autosuggestions
zinit load chrissicool/zsh-256color
zinit load hcgraf/zsh-sudo 
zinit load zsh-users/zsh-completions
zinit ice wait'!0'; zinit load mdarocha/zsh-windows-title
zinit ice depth=1; zinit light romkatv/powerlevel10k


# Create and load everything from ~/.zfunc
mkdir -p ~/.zfunc
fpath+=~/.zfunc


# Load docker and docker-compose autocompletions if installed
if command -v docker &> /dev/null;
  then	if [ ! -d ~/.zfunc/_docker ]; then
		docker completion zsh > ~/.zfunc/_docker
	fi
fi
# Load rustup and cargo completions
if command -v rustup &> /dev/null; then
	if [ ! -d ~/.zfunc/_rustup ]; then
		rustup completions zsh rustup > ~/.zfunc/_rustup
		cat $(rustc --print sysroot)/share/zsh/site-functions/_cargo > ~/.zfunc/_cargo
	fi
fi


# Bindkeys
bindkey "^[[3~"         delete-char
bindkey "^[3;5~"        delete-char
bindkey "^[[1;5C"	forward-word
bindkey "^[[1;5D"	backward-word
bindkey '5~'		kill-word
bindkey '^H'		backward-kill-word
bindkey -e


# Historysize
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000


# Tab-behaviour
zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES
zstyle ':completion::complete:*' gain-privileges 1
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


## Aliases
# Updatefunction
u () {
	if read -q "choice?Update .zshrc itself? (y/n usually yes)"; then
		echo ""
		curl -o ~/.zshrc "https://raw.githubusercontent.com/Nathan-Mossaad/zshrc/main/.zshrc"
		source .zshrc
	fi
	echo ""
	if command -v apt &> /dev/null; then
		sudo apt upgrade --yes
	fi
	if command -v dnf &> /dev/null; then
		sudo dnf update -y
	fi
	if command -v yay &> /dev/null; then
		yes y | yay
	fi
	if command -v flatpak &> /dev/null; then
		sudo flatpak update -y
		flatpak update -y
	fi
	if command -v pkg &> /dev/null; then
		pkg update -y
	fi
	if command -v rustup &> /dev/null; then
		rustup self update
		rustup update
		rustup completions zsh rustup > ~/.zfunc/_rustup
		cat $(rustc --print sysroot)/share/zsh/site-functions/_cargo > ~/.zfunc/_cargo
	fi
	zinit self-update
	zinit update --all
}

# Clear
alias c="clear"

# List all files in current Directory
auto-run () { 
  if [ ${#${(z)BUFFER}} -eq 0 ]; then
    if command -v lsd &> /dev/null; then
      lsd -alh --color auto
    else
      ls -alh --color
    fi
  fi
  zle accept-line
}
zle -N auto-run
bindkey '^M' auto-run

# Command for safe session
if command -v screen &> /dev/null; then
  alias s="screen -RUSd 'nathans-safe-session'"
fi


# Scriptpath
export PATH=$HOME/.local/bin:$PATH

# Load config
autoload -Uz compinit
compinit