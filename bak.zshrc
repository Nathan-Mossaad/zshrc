# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.zinit/bin/zinit.zsh


#zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker
#zinit snippet https://github.com/docker/compose/blob/master/contrib/completion/zsh/_docker-compose
zinit snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/command-not-found/command-not-found.plugin.zsh
zinit load zsh-users/zsh-syntax-highlighting
zinit load zsh-users/zsh-autosuggestions
zinit load chrissicool/zsh-256color
zinit load hcgraf/zsh-sudo 
zinit load zsh-users/zsh-completions


zinit ice depth=1; zinit light romkatv/powerlevel10k


bindkey "^[[3~"         delete-char
bindkey "^[3;5~"        delete-char
bindkey "^[[1;5C"	forward-word
bindkey "^[[1;5D"	backward-word
bindkey '5~'		kill-word
bindkey '^H'		backward-kill-word
bindkey -e

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES
zstyle ':completion::complete:*' gain-privileges 1

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


alias u="sudo apt upgrade --yes; sudo dnf update -y; yes y | yay; flatpak update -y; zinit self-update; zinit update --all; curl -o ~/.zshrc "https://raw.githubusercontent.com/Nathan-Mossaad/zshrc/main/.zshrc""
alias c="clear"


auto-run () { 
  if [ ${#${(z)BUFFER}} -eq 0 ]; then
    clear; ls -alh --color; echo ""
  fi
  zle accept-line
}
zle -N auto-run
bindkey '^M' auto-run


export PATH=$HOME/.local/bin:$PATH
