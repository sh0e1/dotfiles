# zinit initialization
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Plugins
zinit light zsh-users/zsh-history-substring-search
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zdharma-continuum/fast-syntax-highlighting

zinit ice pick"init.sh"
zinit light b4b4r07/enhancd

zinit ice pick"contrib/completion/git-prompt.sh"
zinit light git/git

#zinit ice lucid depth"1" blockf
#zinit light yuki-yano/zeno.zsh

zinit ice as"completion"
zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

# Apply fast-syntax-highlighting theme overlay
# https://github.com/zdharma-continuum/fast-syntax-highlighting/blob/master/THEME_GUIDE.md
fast-theme XDG:overlay 1>/dev/null
