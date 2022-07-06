#!/bin/bash

# unmount buggy Windows Remote Desktop - Kex thinclient_drives
if mountpoint -q $HOME/thinclient_drives
then
    sudo umount $HOME/thinclient_drives
fi

# In case Kex does not automatically load ~/.Xresouces on your WSL instance, uncomment this block
# load Xresources if exist (to merge settings, add the -merge flag)
#if [ -f "~/.Xresources" ]; then
#    xrdb "$HOME/.Xresources"
#fi

# set wallpaper (if exist)
if [ -x "$HOME/.fehbg" ]; then
    sh "$HOME/.fehbg"
fi
