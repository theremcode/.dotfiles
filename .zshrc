# Exit if not running interactively
[[ $- != *i* ]] && return

# Ensure running in zsh
if [ -z "$ZSH_VERSION" ]; then
  echo "This is not zsh!"
  return
fi

# Load aliases
[[ -f ~/.zsh/aliases.zsh ]] && source ~/.zsh/aliases.zsh

# Load Starship
#[[ -f ~/.zsh/starship.zsh ]] && source ~/.zsh/starship.zsh

# History file for zsh
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory  # Append to the history file instead of overwriting it
setopt incappendhistory  # Write commands to history immediately, not when the shell exits
setopt sharehistory  # Share history between all sessions
setopt hist_ignore_dups  # Don't record duplicate entries
setopt hist_ignore_space  # Don't record entries starting with a space
setopt hist_verify  # Show the command with history expansion before running it

# Load Starship prompt
eval "$(starship init zsh)"

# Set PATH
export PATH=/home/remco/bin:$PATH

# Tmux session management
if ! tmux has-session -t mysession 2>/dev/null; then
  tmux new-session -d -s mysession \; \
    split-window -h \; \
    split-window -v \; \
    select-pane -t 0
fi
tmux attach-session -t mysession
