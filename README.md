dotfiles
========

Collection of various config files. Mainly for Vim, Tmux and Zsh

## Getting Started
run `bootstrap.sh` to create softlinks in your home directory to the config
files in this repo.

### Gotchas
some Vim Plugins rely on 3rd party software.  
[Universal CTags](https://github.com/universal-ctags/ctags)  
[Ag - the silver searcher](https://github.com/ggreer/the_silver_searcher) or
[ripgrep](https://github.com/BurntSushi/ripgrep)
[fzf](https://github.com/junegunn/fzf) the path to fzf needs to be set in .vimrc  

To get the Ctrl-Shift-Arrow shortcut running in Terminal.app the Terminal.app
needs to be configured like
[this](https://github.com/google/terminal-app-function-keys).

run `:Helptags` for all Vim Plugins to enable `:help`
`vim -u NONE -c "helptags {plugin_folder}/doc" -c q`

#### VIM
the Vim colorsheme used can be found here:
<https://github.com/hukl/Smyck-Color-Scheme>

