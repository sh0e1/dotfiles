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
```
