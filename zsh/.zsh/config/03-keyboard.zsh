#! /usr/bin/env zsh
# Configure the keyboard for use with the shell, this makes the non-alphanumeric keys
# bindable using bindkey $key[<keyname>] command
typeset -g -A key

# Function keys
key[F1]="${terminfo[kf1]}"
key[F2]="${terminfo[kf2]}"
key[F3]="${terminfo[kf3]}"
key[F4]="${terminfo[kf4]}"
key[F5]="${terminfo[kf5]}"
key[F6]="${terminfo[kf6]}"
key[F7]="${terminfo[kf7]}"
key[F8]="${terminfo[kf8]}"
key[F9]="${terminfo[kf9]}"
key[F10]="${terminfo[kf10]}"
key[F11]="${terminfo[kf11]}"
key[F12]="${terminfo[kf12]}"

# Navigation cluster
key[Insert]="${terminfo[kich1]}"
key[Delete]="${terminfo[kdch1]}"
key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Up]="${terminfo[kcuu1]}"
key[Left]="${terminfo[kcub1]}"
key[Down]="${terminfo[kcud1]}"
key[Right]="${terminfo[kcuf1]}"

# Others
key[Backspace]="${terminfo[kbs]}"
key[ShiftTab]="${terminfo[cbt]}"
