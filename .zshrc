# Use powerline
USE_POWERLINE="true"

alias pyae='deactivate &> /dev/null; source ./venv/bin/activate'
alias pyde='deactivate'
alias pyenv='python3 -m venv ./venv; source ./venv/bin/activate'
#alias fzf-open='fzf | xargs -I {} xdg-open {}'
alias fzf-open=' (fzf --height 40% --reverse </dev/tty) | xargs -I {} xdg-open {}'
alias yts='ytfzf -t'
#alias yts -f='ytfzf'
notflixpath='/home/christian/dev/python/web-scraping/media/'
alias notflix='${notflixpath}venv/bin/python3.10 ${notflixpath}notflix.py'

#---------------------------------------------- chpwd pyvenv ---
python_venv() {
  MYVENV=./venv
  # when you cd into a folder that contains $MYVENV
  [[ -d $MYVENV ]] && source $MYVENV/bin/activate > /dev/null 2>&1
  # when you cd into a folder that doesn't
  [[ ! -d $MYVENV ]] && deactivate > /dev/null 2>&1
}
autoload -U add-zsh-hook
add-zsh-hook chpwd python_venv

python_venv

# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi


