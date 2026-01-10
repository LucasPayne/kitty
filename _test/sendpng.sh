
ID=16
rows=10
cols=20
tmux_passthrough=0
screen_passthrough=0
vim_passthrough=0
kitty_remote_passthrough=0
skip_image=0

mode="$1"
shift
if [ "$mode" = "tmux" ]
then
    tmux_passthrough=1
fi
if [ "$mode" = "screen" ]
then
    screen_passthrough=1
fi
if [ "$mode" = "vim" ]
then
    vim_passthrough=1
fi
if [ "$mode" = "kitty" ]
then
    kitty_remote_passthrough=1
fi
if [ "$mode" = "skip" ]
then
    skip_image=1
fi

if [ $skip_image -eq 0 ]
then
    #!/bin/bash
    transmit_png() {
        data=$(base64 "$1")
        data="${data//[[:space:]]}"
        builtin local pos=0
        builtin local chunk_size=4096
        while [ $pos -lt ${#data} ]; do
            builtin printf "\e_G"
            [ $pos = "0" ] && printf "q=2,a=t,f=100,i=${ID},"
            builtin local chunk="${data:$pos:$chunk_size}"
            pos=$(($pos+$chunk_size))
            [ $pos -lt ${#data} ] && builtin printf "m=1"
            [ ${#chunk} -gt 0 ] && builtin printf ";%s" "${chunk}"
            builtin printf "\e\\"
        done
    
        printf "\e_Gq=2,a=p,U=1,i=${ID},c=${cols},r=${rows}\e\\"
    }
    
    if [ $tmux_passthrough -eq 1 ]
    then
        transmit_png "$1" | tmux-passthrough
    elif [ $screen_passthrough -eq 1 ]
    then
        transmit_png "$1" | screen-passthrough
    elif [ $vim_passthrough -eq 1 ]
    then
        transmit_png "$1" | vim-passthrough
    elif [ $kitty_remote_passthrough -eq 1 ]
    then
        transmit_png "$1" > /tmp/text
        kitty @ send-text --from-file=/tmp/text
    else
        transmit_png "$1"
    fi
    
    read -r w h < <(identify -format "%w %h\n" "$1")
fi

mapfile -t diacritics < <(cat <<EOF
0305
030D
030E
0310
0312
033D
033E
033F
0346
034A
034B
034C
0350
0351
0352
0357
035B
0363
0364
0365
0366
0367
0368
0369
036A
036B
036C
036D
036E
036F
0483
0484
0485
0486
0487
0592
0593
0594
0595
0597
0598
0599
059C
059D
059E
059F
05A0
05A1
05A8
05A9
05AB
05AC
05AF
05C4
0610
0611
0612
0613
0614
0615
0616
0617
0657
0658
0659
065A
065B
065D
065E
06D6
06D7
06D8
06D9
06DA
06DB
06DC
06DF
06E0
06E1
06E2
06E4
06E7
06E8
06EB
06EC
0730
0732
0733
0735
0736
073A
073D
073F
0740
0741
0743
0745
0747
0749
074A
EOF
)

for i in $(seq 1 $rows)
do
    # Test breaking up the image
    # printf '%*s' "$i"

    printf "\e[38;5;${ID}m"
    for j in $(seq 1 $cols)
    do
        printf "\U10EEEE\U${diacritics[$i]}\U${diacritics[$j]}"
    done
    printf "\e[39m\n"
done
