#!/bin/ksh

# xterm.sh - to spawn a new terminal for use with cwm

# Require Packages:
#   transset-df-6p3.tgz
#   hermit-font-1.21p1.tgz
#   mixfont-mplus-ipa-20060520p7.tgz

#-------------------------------------------------------------------------------
_OPACITY=0.75
_FONT_SIZE=12
_FG_COLOR=white
_BG_COLOR=black

#-------------------------------------------------------------------------------
_US_FONT=Hermit:style=Regular
_JP_FONT=M+2P+IPAG:style=regular

fc-list | grep -q ${_US_FONT}
[[ $? -eq 1 ]] && _US_FONT=""
fc-list | grep -q ${_JP_FONT}
[[ $? -eq 1 ]] && _JP_FONT=""

#-------------------------------------------------------------------------------
_TITLE="XTerm_$$"
_PROGRAM="exec ksh -c 'tmux -2'"

pgrep -q xcompmgr
[[ $? -eq 0 ]] && _PROGRAM="transset-df ${_OPACITY} --name ${_TITLE} \
                      --no-regex >/dev/null; ${_PROGRAM}"
#-------------------------------------------------------------------------------
xterm -fa ${_US_FONT} -fd ${_JP_FONT} -fg ${_FG_COLOR} -bg ${_BG_COLOR} \
    -fs ${_FONT_SIZE} -title ${_TITLE} +sb -e "${_PROGRAM}"

