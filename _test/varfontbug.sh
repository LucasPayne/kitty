# When w != 0 then the width is s*w.
# But scale is calculated as s*(n/d)
printf "\e]66;s=2:n=1:d=2:v=2:w=2;hello\aOK\n\n"
printf "\e]66;s=2:n=1:d=2:v=2:w=3;hello\aOK\n\n"
printf "\e]66;s=3:n=1:d=2:v=2:w=2;big\aOK\n\n\n"
