xset r rate 300 50 &
xset b off &
xset s off &
xset -dpms &

setxkbmap se &

feh --bg-scale /home/nlantau/Bilder/gt_2.jpg

unclutter -idle 3 &

exec /home/nlantau/.config/slstatus/slstatus &

exec dwm
