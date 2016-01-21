#!/bin/bash

if [ $# -eq 2 ]; then
  urllist=$1
  target_string=$2
  recording_flg=`pgrep -fa recordmydesktop | wc -l`
  chromium_flg=`pgrep -fa chromium-browse | wc -l`
else
  echo "Not enough args."
  exit 1
fi

while read url; do
  act_flg=`wget -q -O - $url | grep $target_string | wc -l`

  if [ 0 -lt $act_flg -a 0 = $recording_flg ]; then

    chromium-browser --add $url &
    sleep 10s
    recordmydesktop --width 550 --height 550 -y 200 -o /home/imaji/record/`date +'%Y%m%d_%H_%M_%S'` &

    break
  fi

  if [ 0 -lt $act_flg -a 0 -lt $recording_flg ]; then
    break
  fi
done < $urllist

if [ 0 = $act_flg -a 0 -lt $recording_flg -a 0 -lt $chromium_flg ]; then
  pkill --signal=SIGINT recordmydesktop
  killall chromium-browse
fi
