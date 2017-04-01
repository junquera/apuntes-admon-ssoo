# Contar todas las líneas en blanco de un archivo y crear un nuevo archivo eliminando todas ellas
egrep -e '^\s*$' $1 | wc -l
egrep -v -e '^\s*$' $1 > $2
