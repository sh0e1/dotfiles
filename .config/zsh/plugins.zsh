# plugins.zsh - Plugin management with zinit

# Initialize zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[[ ! -d $ZINIT_HOME ]] && mkdir -p "$(dirname $ZINIT_HOME)"
[[ ! -d $ZINIT_HOME/.git ]] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Essential plugins
zinit light zsh-users/zsh-history-substring-search
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zdharma-continuum/fast-syntax-highlighting

# enhancd - Enhanced cd command
zinit ice pick"init.sh"
zinit light b4b4r07/enhancd

# Git prompt support
zinit ice pick"contrib/completion/git-prompt.sh"
zinit light git/git

# Docker completion
zinit ice as"completion"
zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

# Apply fast-syntax-highlighting theme overlay
fast-theme XDG:overlay 1>/dev/null 2>&1

# Replay compdef calls (required for enhancd compatibility)
# https://github.com/b4b4r07/enhancd/issues/172#issuecomment-1492250042
zinit cdreplay -q
