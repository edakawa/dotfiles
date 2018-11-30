# display background image
feh --bg-center $HOME/.img/galaxy1920x1080.jpg

# used to create transparent window
xcompmgr -c -o.2 &

# display system monitor
conky --config=~/.conkyrc &

# hide mouse corsor when keyboard typing
xbanish &

# set up japanese input method
export LANG=ja_JP.UTF-8
export XMODIFIERS="@im=SCIM"
export GTK_IM_MODULE=xim
scim -d

# start my best window manager
cwm
