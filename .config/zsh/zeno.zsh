# if defined load the configuration file from there
export ZENO_HOME=$XDG_CONFIG_HOME/zeno

# if disable deno cache command when plugin loaded
# export ZENO_DISABLE_EXECUTE_CACHE_COMMAND=1

# if enable fzf-tmux
export ZENO_ENABLE_FZF_TMUX=1

# if setting fzf-tmux options
export ZENO_FZF_TMUX_OPTIONS="-d 50%"

# Experimental: Use UNIX Domain Socket
export ZENO_ENABLE_SOCK=1

# if disable builtin completion
export ZENO_DISABLE_BUILTIN_COMPLETION=1

# default
export ZENO_GIT_CAT="cat"
# git file preview with color
# export ZENO_GIT_CAT="bat --color=always"

# default
export ZENO_GIT_TREE="tree"
# git folder preview with color
# export ZENO_GIT_TREE="exa --tree"

if [[ -n $ZENO_LOADED ]]; then
  bindkey ' '  zeno-auto-snippet
  bindkey '^m' zeno-auto-snippet-and-accept-line
  bindkey '^i' zeno-completion
  # bindkey '^x '  zeno-insert-space
  # bindkey '^x^m' accept-line
  # bindkey '^x^z' zeno-toggle-auto-snippet
  # bindkey '^r'   zeno-history-selection
  bindkey '^x^s' zeno-insert-snippet
  # bindkey '^x^f' zeno-ghq-cd
fi
