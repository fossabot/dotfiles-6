export ZPLUG_HOME=$HOME/.zplug
[[ -d ~/.zplug ]] || {
  mkdir -p $ZPLUG_HOME
  git clone https://github.com/zplug/zplug $ZPLUG_HOME
  source ~/.zplug/init.zsh && zplug update
}
source ~/.zplug/init.zsh

# the shell starts slow if this file does not exist
[ -f $ZPLUG_LOADFILE ] || touch $ZPLUG_LOADFILE

# zsh-completion-generator folder
export GENCOMPL_FPATH=~/dotfiles/completions

# zsh settings
export HISTFILE=/home/arsham/Dropbox/Home/.zsh_history
export HISTSIZE=999999999
export SAVEHIST=$HISTSIZE
export LANG=en_GB.UTF-8
export LC_CTYPE=en_GB.UTF8
export EDITOR=nano
export VISUAL=nano

# zsh functions
export fpath=(~/dotfiles/functions "${fpath[@]}")

. ~/dotfiles/zsh_conf/powerlevel9k.zsh-theme

zplug "junegunn/fzf-bin",                        from:gh-r, as:command, rename-to:fzf, use:"*linux*amd64*"
zplug "bhilburn/powerlevel9k",                   use:powerlevel9k.zsh-theme, as:theme
zplug "tarruda/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting",       defer:2
zplug "lib/key-bindings",                        from:oh-my-zsh
zplug "plugins/command-not-found",               from:oh-my-zsh
zplug "plugins/RobSis/zsh-completion-generator", from:oh-my-zsh
zplug "plugins/git",                             from:oh-my-zsh
zplug "plugins/emoji",                           from:oh-my-zsh
zplug "plugins/docker",                          from:oh-my-zsh
zplug "modules/boot2docker",                     from:prezto
zplug "plugins/ssh-agent",                       from:prezto
zplug "plugins/completion",                      from:prezto
zplug "modules/golang",                          from:prezto
zplug "modules/colored-man-pages",               from:prezto
zplug "plugins/z",                               from:prezto
zplug "modules/pip",                             from:prezto
zplug "modules/virtualenv",                      from:prezto
zplug "modules/virtualenvwrapper",               from:prezto
# zplug 'zplug/zplug',                             hook-build:'zplug --self-manage'
# after adding new plugins, you must run: zplug install

zplug load

[ -f ~/.zshrc-local ] && source ~/.zshrc-local
[ -f ~/dotfiles/.zaliases ] && source ~/dotfiles/.zaliases

# fzf settings
. ~/dotfiles/zsh_conf/fzf

# history search
if zplug check zsh-users/zsh-history-substring-search; then
    bindkey '\eOA' history-substring-search-up
    bindkey '\eOB' history-substring-search-down
fi

zstyle ':prezto:module:autosuggestions' color 'yes'

if [[ -d ~/dotfiles/functions ]]; then
   for func in $(find ~/dotfiles/functions -type f -exec realpath {} +); do
      unhash -f $func 2>/dev/null
      autoload +X $func
   done
fi

if [[ -d ~/dotfiles/widgets ]]; then
   for func in $(find ~/dotfiles/widgets -type f -exec realpath {} +); do
      source $func
   done
fi
