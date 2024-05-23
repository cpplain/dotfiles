export CLICOLOR=1

alias l1="ls -a1"
alias la="ls -al"

eval "$(starship init zsh)"

if [ -f $ZDOTDIR/.zshrc_servicenow ]; then
    source $ZDOTDIR/.zshrc_servicenow
fi
