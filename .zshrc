eval "$(/opt/homebrew/bin/brew shellenv)"

export EDITOR=nvim

# Extend Autocomplete Search Path
fpath=($HOME/.zsh/lib/completions $fpath)
fpath=($HOME/.zsh/lib/zfunctions $fpath)

# load all config files from lib folder
for config_file ($ZSH/lib/*.zsh) source $config_file

# Load and run compinit
autoload -U compinit
compinit -i

# time output format
TIMEFMT=$'\n================\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
