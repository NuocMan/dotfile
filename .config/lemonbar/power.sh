#!/bin/bash

declare -A commands

commands['Suspend/Sleep']='systemctl suspend'
commands['Hibernate']='systemctl hibernate'
commands['Reboot/Restart']='systemctl reboot'
commands['Shutdown/Poweroff']='systemctl poweroff'

title='rofi-power'

command=$( (IFS=$'\n'; echo "${!commands[*]}") | rofi -dmenu -i -p "${title}")

${commands[$command]}
