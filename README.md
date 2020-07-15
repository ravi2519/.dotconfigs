### ZSH

```sh
$ sudo apt install zsh
$ curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
$ curl 'https://raw.githubusercontent.com/ravi2519/.dotconfigs/master/.zshrc' -o ~/.zshrc
$ git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.dotconfigs/.oh-my-zsh 
```

### TMUX

```sh
$ cd
$ git clone https://github.com/gpakosz/.tmux.git
$ curl 'https://raw.githubusercontent.com/ravi2519/.dotconfigs/master/.tmux.conf' -o ~/.tmux.conf
```

### Bash for FreeBSD

```sh
$ cd
$ curl 'https://raw.githubusercontent.com/ravi2519/.dotconfigs/master/.bash_profile' -o ~/.bash_profile
$ curl 'https://raw.githubusercontent.com/ravi2519/.dotconfigs/master/.dir_colors' -o ~/.dir_colors
$ sr chsh -s /usr/local/bin/bash ${whoami}
$ source .bash_profile
```
