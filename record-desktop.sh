#!/bin/bash

### How to use.
### FILE.sh [URL] [TARGE STRING] [FROM MAIL ADDRESS] [TO MAIL ADDRESS]

while true
do
act_flg=`wget -q -O - $1|grep $2 | wc -l`
open_flg=`ps acx|grep [r]ecordmydesktop | wc -l`

if [ 0 -lt $act_flg ]; then
 if [ 0 = $open_flg ]; then
  chromium-browser --add $1 &
  sleep 10s
  recordmydesktop --width 550 --height 550 -y 200 -o /home/imaji/record/`date +'%Y%m%d_%H_%M_%S'` &
 fi
# echo $1|mail -s $3 -aFrom:$3 $4
else
 if [ 1 = $open_flg ]; then
  pkill --signal=SIGINT recordmydesktop
  killall chromium-browse
 fi
fi
sleep 600
done
