# $OpenBSD: dot.profile,v 1.7 2020/01/24 02:09:51 okan Exp $
#
# sh/ksh initialization

PATH=$HOME/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin:/usr/local/bin:/usr/local/sbin:/usr/games
export PATH HOME TERM

export ENV=${HOME}/.kshrc
export CVSROOT="anoncvs@anoncvs.jp.openbsd.org:/cvs"
export EDITOR=mg
export CVSEDITOR=mg
export FCEDIT=mg
export HISTFILE=${HOME}/.sh_history
export HISTSIZE=65535
export MANPAGER="less --hilite-search --ignore-case --silent"
export HISTCONTROL=ignoredups:ignorespace
