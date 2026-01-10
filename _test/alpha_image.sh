printf '\e_Gf=32,a=T,s=10,v=10,c=10,r=10,z=-1;'
(
    for i in {1..100}
    do
        # printf '\xFF\x00\x00'
        # printf '\xFF\x00\x00\x80'
        printf "\xFF\x00\x00$(printf '\\x%02x' $((i * 2)))"
    done
) | base64 -w 0
printf '\e\\'

printf '\n\r'

printf '\e[10A\r'
printf '\e]66;s=2:w=10;hello\a\n'
printf '%*s' 7 | tr ' ' '\n'
printf '\e]66;s=2:w=10;world\a\n'
printf '\n'


