export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="amuse"
plugins=(argocd ansible  aws azure terraform golang git zsh-autosuggestions zsh-syntax-highlighting helm kubectl brew)
source $ZSH/oh-my-zsh.sh
eval "$(starship init zsh)"
alias aa='sudo apt update'
alias ae='sudo apt install'
alias aq='sudo apt upgrade'
alias dk='docker'
alias dw='cd ~/Downloads'
alias k='kubectl'
complete -F __start_kubectl k
alias kk='k get nodes,pods -o wide'
alias ktp='kubectl top pods'
alias ktn='kubectl top nodes'
alias ktpa='kubectl top pod -A'
alias kde='k delete'
alias ked='k edit deployment'
alias hls='helm ls'
alias hs='helm status'
alias ff='fzf'
alias kc='kubectx'
alias kn='kubens'
alias ww='cd ~/workspace'
alias ic='cd ~/workspace/ic'
alias tt='cd ~/workspace/tfaz'
alias tf='terraform'
alias tg='terragrunt'
alias dg='dig +short myip.opendns.com @resolver1.opendns.com'
alias ll='ls -lcrht'
# kubernetes
alias kp='kubectl get pods'
alias kshell='kubectl run --rm utils -it --image arunvelsriram/utils bash'
alias ka='kubectl get all'
alias kg='kubectl get'
alias kgn='kubectl get nodes'
alias kp='kubectl get pods'
alias kl='kubectl logs'
alias kf='kubectl logs -f'
alias kd='kubectl describe'
alias kdp='kubectl describe pod'
alias kdd='kubectl describe deployment'
alias kds='kubectl describe service'
alias kdt='kubectl describe statefulset'
autoload -U colors && colors
alias ks='kubectl get svc'
alias kpa='kubectl get pods -A'
alias ke='kubectl edit'
alias ns='nslookup -type=any'
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias gcli='gcloud'
alias n='nvim'
alias beam="cd ~/workspace/beamer"
alias c='clear'

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

eval "$(ssh-agent -s)" > /dev/null 2>&1
ssh-add ~/.ssh/jamilshaikh07-github > /dev/null 2>&1

export PATH=$HOME/.local/bin:$PATH
alias ub='multipass shell dazzling-grub'

alias wt='wezterm cli set-tab-title'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '$HOME/google-cloud-sdk/path.zsh.inc' ]; then . '$HOME/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '$HOME/google-cloud-sdk/completion.zsh.inc' ]; then . '$HOME/google-cloud-sdk/completion.zsh.inc'; fi


export KUBE_EDITOR='code --wait'
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

