# Mostar el número de directorios que contiene el directorio actual (sin entrar recursivamente)
DIR=$1
find $DIR -maxdepth 1 -type d 2>/dev/null | wc -l
