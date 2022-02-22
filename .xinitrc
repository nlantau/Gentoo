xset r rate 300 50 &
xset b off &
xset s off &
xset -dpms &

setxkbmap se &

feh --bg-scale /home/nlantau/Bilder/bg/g2.jpg

unclutter -idle 2 &

exec /home/nlantau/.config/slstatus/slstatus &

exec dbus-launch --exit-with-session dwm
