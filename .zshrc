# Use powerline
USE_POWERLINE="true"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

#alias fzf-open='fzf | xargs -I {} xdg-open {}'
alias fzf-open=' (fzf --height 40% --reverse </dev/tty) | xargs -I {} xdg-open {}'
alias yts='ytfzf -t'
notflixpath='/home/christian/dev/python/web-scraping/media/'
alias notflix='${notflixpath}venv/bin/python3.10 ${notflixpath}notflix.py'
alias rm='rm -I --preserve-root'
alias vim='nvim'
alias v='nvim'
alias z='zathura'
alias speedread='tspreed'
#----Git--------------------------------------------------------
#alias gitupdate='(for l in `find . -name .git | xargs -i dirname {}` ; do cd $l; pwd; git pull; cd -; done)'
alias amend='commit --amend -m'
alias commit='commit -m'
alias rndwall='styli.sh -k -s anime'
alias clock='tty-clock'
#----Downloading................................................
# alias dla= "yt\-dlp \-f \'ba\'"
# alias dl= "yt\-dlp"
# alias dlo= "stream\-dl"
#----Media-----------------------------------------------------
alias i='nsxiv'
#----Utilities-------------------------------------------------
alias la='exa --icons -a --group-directories-first'
alias ll='exa --icons -lah --group-directories-first'
alias ls='exa --icons --group-directories-first'
alias tree='exa --icons --tree'
alias cat='bat'
###Manpager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
#export MANPAGER="nvim -c 'set ft=man' -"

alias lsa='br -dph'
#alias ls='br -dp'
#-----Python------------------------------------------------------
alias pyae='deactivate &> /dev/null; source ./venv/bin/activate'
alias pyde='deactivate'
alias pyenv='python3 -m venv ./venv; source ./venv/bin/activate'
#---------------------------------------------- chpwd pyvenv ---
python_venv() {
  MYVENV=./venv
  # when you cd into a folder that contains $MYVENV
  [[ -d $MYVENV ]] && source $MYVENV/bin/activate >/dev/null 2>&1
  # when you cd into a folder that doesn't
  [[ ! -d $MYVENV ]] && deactivate >/dev/null 2>&1
}
autoload -U add-zsh-hook
add-zsh-hook chpwd python_venv

python_venv

source /home/christian/.config/broot/launcher/bash/br
