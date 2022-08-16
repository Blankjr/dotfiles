typeset -U path PATH

export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
# Other XDG paths
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}

path=(~/.local/bin $path)
export PATH

#fzf default settings
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
#DEFAULT Apps
export EDITOR="nvim"
export READER="zathura"
export VISUAL="nvim"
export TERMINAL="kitty"
export BROWSER="brave"
export VIDEO="mpv"
export IMAGE="nsxiv"
export COLORTERM="truecolor"
export OPENER="xdg-open"
export PAGER="less"

# lf icons
# export LF_ICONS="di=📁:\
# fi=📃:\
# tw=🤝:\
# ow=📂:\
# ln=⛓:\
# or=❌:\
# *.txt=✍:\
# *.mom=✍:\
# *.me=✍:\
# *.ms=✍:\
# *.png=🖼:\
# *.webp=🖼:\
# *.ico=🖼:\
# *.gif=🖼:\
# *.svg=🗺:\
# *.tif=🖼:\
# *.tiff=🖼:\
# *.xcf=🖌:\
# *.html=🌎:\
# *.xml=📰:\
# *.gpg=🔒:\
# *.css=🎨:\
# *.pdf=📚:\
# *.djvu=📚:\
# *.epub=📚:\
# *.csv=📓:\
# *.xlsx=📓:\
# *.tex=📜:\
# *.md=📘:\
# *.r=📊:\
# *.R=📊:\
# *.rmd=📊:\
# *.Rmd=📊:\
# *.m=📊:\
# *.mp3=🎵:\
# *.opus=🎵:\
# *.ogg=🎵:\
# *.m4a=🎵:\
# *.zip=📦:\
# *.rar=📦:\
# *.7z=📦:\
# *.tar.gz=📦:\
# *.z64=🎮:\
# *.v64=🎮:\
# *.n64=🎮:\
# *.gba=🎮:\
# *.nes=🎮:\
# *.gdi=🎮:\
# *.1=ℹ:\
# *.nfo=ℹ:\
# *.info=ℹ:\
# *.log=📙:\
# *.iso=📀:\
# *.img=📀:\
# *.bib=🎓:\
# *.ged=👪:\
# *.part=💔:\
# *.jar=♨:\
# *.java=♨:\
# "
