#!/bin/bash

width=550
height=550
coordinate_y=200
script_dir_path=$(dirname $(readlink -f $0))

while true
do
  [ $# -ne 2 ] && exit 1

  urllist=$1
  target_string=$2
  recording_flg=`pgrep -fa recordmydesktop | wc -l`
  chromium_flg=`pgrep -fa chromium-browse | wc -l`

  while read url; do

    if wget -q -O - "$url" | grep -sq "$target_string"; then

      if [ 0 = "$recording_flg" ]; then
        chromium-browser --add $url &
        sleep 10s
        recordmydesktop --width $width --height $height -y $coordinate_y -o $script_dir_path"/"`date +'%Y%m%d_%H_%M_%S'` &
      fi
      break

    fi

  done < $urllist

  if [ 0 -lt "$recording_flg" -a 0 -lt "$chromium_flg" ]; then
    pkill -f --signal=SIGINT recordmydesktop
    pkill -f chromium-browse
  fi
  sleep 5m
done
