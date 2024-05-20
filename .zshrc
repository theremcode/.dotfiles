[[ -f ~/.zsh/aliases.zsh ]] && source ~/.zsh/aliases.zsh
#[[ -f ~/.zsh/starship.zsh ]] && source ~/.zsh/starship.zsh

# History file for zsh
HISTFILE=~/.zsh_history

# Load Starship
eval "$(starship init zsh)"

export PATH=/home/remco/bin:$PATH
tmux new-session -d -s mysession \; split-window -h \; split-window -v \; select-pane -t 0 \; attach-session -t mysession