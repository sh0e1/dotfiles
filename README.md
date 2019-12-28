# dotfiles

## Usage

```bash
$ ./install.sh
```

### vim

```
:PluginInstall
:GoInstallBinaries
```

### nvim

```
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.cache/dein
pip3 install --user pynvim

:UpdateRemotePlugins
```

### tmux

```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# vi ~/.tmux/plugins/nord-tmux/src/nord-status-content.conf
set -g status-right "#{prefix_highlight}#[fg=brightblack,bg=black,nobold,noitalics,nounderscore]#[fg=white,bg=brightblack] #(/usr/local/bin/zsh $HOME/.tmux/plugins/kube-tmux/kube.tmux 250 white cyan) #[fg=white,bg=brightblack,nobold,noitalics,nounderscore]#[fg=white,bg=brightblack] %Y-%m-%d #[fg=white,bg=brightblack,nobold,noitalics,nounderscore]#[fg=white,bg=brightblack] %H:%M #[fg=cyan,bg=brightblack,nobold,noitalics,nounderscore]#[fg=black,bg=cyan,bold] #H "
```
