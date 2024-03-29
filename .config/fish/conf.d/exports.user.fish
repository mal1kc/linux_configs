# Set a cursor size
export XCURSOR_SIZE=24

export EDITOR='/sbin/nvim'
export SUDO_EDITOR=$EDITOR

# export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.emacs-profiles/doomemacs/bin:$HOME/.local/bin:$PATH"
export XDG_DATA_DIRS="/usr/share:$XDG_DATA_DIRS"

export FZF_DEFAULT_OPTS="--black --preview 'bat --color=always --style=numbers --line-range=:500 {}' --height 90%"
# export FZF_DEFAULT_OPTS="--black --color=spinner:\#F8BD96,hl:\#F28FAD --color=fg:\#D9E0EE,header:\#F28FAD,info:\#DDB6F2,pointer:\#F8BD96 --color=marker:\#F8BD96,fg+:\#F2CDCD,prompt:\#DDB6F2,hl+:\#F28FAD --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
