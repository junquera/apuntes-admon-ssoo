# Mostrar el número de usuarios diferentes que hay conectados en un sistema
who -u | tr " " "#" | cut -d# -f1 | sort -u | wc -l
