
text=O
for i in {1..255}
do
    rgb_fg="$i 0 0"
    rgb_bg="$((256 - i)) 0 0"
    printf '\e[38;2;%d;%d;%dm\e[48;2;%d;%d;%dm%s\e[39m\e[49m' $rgb_fg $rgb_bg "$text"
done
printf '\n'
