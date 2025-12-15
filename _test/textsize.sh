for i in {1..15}
do
    printf "\e]66;n=$i:d=$((i+1)):w=10;hello\a\n"
done

