
for i in {1..15}
do
    printf "\e]66;n=$i:d=$((i+1)):w=10;hello\a\n"
done

# Showcase wrapping of a text block treated as a "wide char".
c=$(tput cols)
echo c: $c


# DECAWM—Autowrap Mode
# https://vt100.net/docs/vt510-rm/DECAWM.html

printf '\e[?7h'
for i in {1..5}
do
    printf '%*s' "$((c - 10 + i))" | tr ' ' '='
    printf "\e]66;n=1:d=1:w=7;abcdefg\a\n"
done

printf '\e[?7l'
for i in {1..5}
do
    printf '%*s' "$((c - 10 + i))" | tr ' ' '='
    printf "\e]66;n=1:d=1:w=7;abcdefg\a\n"
done

printf '\e[?7h'
for i in {1..5}
do
    printf '%*s' "$((c - 2*(10 - i)))" | tr ' ' '='
    printf "\e]66;s=2:w=7;abcdefg\a\n\n"
done

printf '\e[?7l'
for i in {1..5}
do
    printf '%*s' "$((c - 2*(10 - i)))" | tr ' ' '='
    printf "\e]66;s=2:w=7;abcdefg\a\n\n"
done
