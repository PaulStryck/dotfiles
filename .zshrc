export ZSH=~/.zsh

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export EDITOR=vi

# load all config files from lib folder
for config_file ($ZSH/lib/*.zsh) source $config_file

# Extend Autocomplete Search Path
fpath=($HOME/.zsh/lib/completions $fpath)

# Load and run compinit
autoload -U compinit
compinit -i

PATH=/usr/local/bin:/usr/local/sbin:$PATH

# time output format
TIMEFMT=$'\n================\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E'
