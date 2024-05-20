[[ -f ~/.zsh/aliases.zsh ]] && source ~/.zsh/aliases.zsh
#[[ -f ~/.zsh/starship.zsh ]] && source ~/.zsh/starship.zsh

# History file for zsh
HISTFILE=~/.zsh_history

# Load Starship
eval "$(starship init zsh)"

export PATH=/home/remco/bin:$PATH
if ! tmux has-session -t mysession 2>/dev/null; then
  tmux new-session -d -s mysession \; \
    split-window -h \; \
    split-window -v \; \
    select-pane -t 0
fi
tmux attach-session -t mysession
