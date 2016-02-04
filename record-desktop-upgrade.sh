#!/bin/bash

width=550
height=550
coordinate_y=200
script_dir_path=$(dirname $(readlink -f $0))

urllist=$1
targetlist=$(cat $2 | xargs | sed -e 's/ /|/g')
recording_flg=$(pgrep -fa recordmydesktop | wc -l)
chromium_flg=$(pgrep -fa chromium-browse | wc -l)

while true
do
  [ $# -ne 2 ] && { echo "Not enough arguments!!"; exit 1; }

  while read url; do

    if wget -q -O - "$url" | egrep -sq "$targetlist"; then

      if [ 0 = "$recording_flg" ]; then
        chromium-browser --add $url &
        sleep 10s
        recordmydesktop --width $width --height $height -y $coordinate_y -o $script_dir_path"/"$(date +'%Y%m%d_%H%M%S') &
      fi
      break 2

    fi

  done < $urllist

  if [ 0 -ne "$recording_flg" -a 0 -ne "$chromium_flg" ]; then
    pkill -f --signal=SIGINT recordmydesktop
    pkill -f chromium-browse
  fi
  sleep 5m
done
