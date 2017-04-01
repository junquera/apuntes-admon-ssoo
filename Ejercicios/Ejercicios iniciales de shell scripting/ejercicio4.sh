# Mostrar el nombre de todos los usuarios diferentes que hay conectados en un sistema en una única línea separados por guiones
who -u | tr " " "#" | cut -d# -f1 | sort -u | tr "\n" "-" | cut -d- -f1-$(who -u | tr " " "#" | cut -d# -f1 | sort -u | wc -l)
