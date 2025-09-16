# zmodload zsh/zprof

# Top of .zshrc
ZSH_DISABLE_COMPFIX=true
ZSH_AUTO_UPDATE=true

# Smarter completion initialization
autoload -Uz compinit
compinit -u

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh

# ZSH & Starship
# plugins=( git zsh-autosuggestions zsh-syntax-highlighting )
# plugins=( git zsh-autosuggestions fast-syntax-highlighting )
plugins=( git kubectl zsh-autosuggestions )
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
# Load Oh-My-Zsh
source $ZSH/oh-my-zsh.sh
# Load Starship
eval "$(starship init zsh)"

# Kubernetes Aliases
alias k='kubectl'
alias kp='kubectl get pods'
alias kk='k get nodes,pods -o wide'
alias ktp='kubectl top pods'
alias ktn='kubectl top nodes'
alias ktpa='kubectl top pod -A'
alias kdel='k delete'
alias kg='kubectl get'
alias kga='kubectl get all'
alias kgn='kubectl get nodes'
alias kl='kubectl logs'
alias kf='kubectl logs -f'
alias kd='kubectl describe'
alias kdp='kubectl describe pod'
alias kdd='kubectl describe deployment'
alias kds='kubectl describe service'
alias kdt='kubectl describe statefulset'
alias ks='kubectl get svc'
alias kpa='kubectl get pods -A'
alias ke='kubectl edit'
alias kshell='kubectl run utils -it --image arunvelsriram/utils bash'
alias kc='kubectx'
alias kn='kubens'
alias kres='kubectl get pods -A -o jsonpath="{range .items[*]}{.metadata.namespace}{\"\t\"}{.metadata.name}{\"\t\"}{range .status.containerStatuses[*]}{.name}{\"\t\"}{.restartCount}{\"\t\"}{.lastState.terminated.reason}{\"\n\"}{end}{end}" | awk '\''$4 > 0'\'' | column -t'
alias kgao='kubectl get all -o wide'
alias kpr='kubectl port-forward'

# ZSH Enhancements
autoload -U colors && colors
complete -F __start_kubectl k

# System Aliases
alias aa='sudo apt update'
alias ae='sudo apt install'
alias aq='sudo apt upgrade'
alias dk='docker'
alias dg='dig +short myip.opendns.com @resolver1.opendns.com'
alias c='clear'
alias ll='ls -lchrt --color=auto'

# File Navigation
alias dw='cd ~/Downloads'
alias ww='cd ~/workspace'
alias ic='cd ~/workspace/ic'
alias dot='cd ~/dotfiles'
alias beam="cd ~/workspace/beamer"
alias wasd="cd ~/workspace/tfaz/homelab"
alias tt="cd ~/workspace/tfaz"
alias acq="cd ~/workspace/acquia"
# Terraform , OpenTofu & Terragrunt
alias tf='terraform'
alias tg='terragrunt'
alias to='tofu'

# Helm
alias hl='helm ls'
alias hls='helm status'
alias hla='helm ls -A'

# Neovim
alias n='nvim'
alias vi='nvim'
alias vim='nvim'

# Tmux & Terminals
alias t='tmux'
alias wt='wezterm cli set-tab-title'
setopt ignore_eof
export IGNOREEOF=10

# GCP & Cloud
alias bpro="gcloud config configurations activate prod-config && gcloud auth application-default set-quota-project getbeamer"
alias bstg="gcloud config configurations activate stg-config && gcloud auth application-default set-quota-project beamer-staging"

# Appearance
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Brew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# SSH Agent
eval "$(ssh-agent -s)" > /dev/null 2>&1
ssh-add ~/.ssh/jamilshaikh07-github > /dev/null 2>&1

# Enable direnv
eval "$(direnv hook zsh)"

# # NVM
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# setting control+u to clear the line from the cursor to the beginning of the line
bindkey "^u" backward-kill-line

# # caraspace
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/jamil-shaikh/google-cloud-sdk/path.zsh.inc' ]; then . '/home/jamil-shaikh/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
# if [ -f '/home/jamil-shaikh/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/jamil-shaikh/google-cloud-sdk/completion.zsh.inc'; fi

# fzf for Control+R and completion
source <(fzf --zsh)


# debuging speed
# zprof
