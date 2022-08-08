#!/bin/sh

#
# ~/.xsession
#
# Executed by xdm/gdm/kdm at login

# Changes Caps-Lock to Escape
setxkbmap eu 
setxkbmap -option caps:escape
