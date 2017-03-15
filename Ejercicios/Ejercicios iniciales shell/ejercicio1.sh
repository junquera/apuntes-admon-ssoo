# Trabajando con una copia del archivo /etc/passwd, insertar un tercer campo en todas las filas que contenga el número de línea
cp /etc/passwd passwd.txt;
cat -n passwd.txt | cut -c1-6 | tr -d " " > nlineas;
cut -d: -f-2 passwd.txt > p1;
cut -d: -f3- passwd.txt > p2;
paste -d: p1 nlineas p2;
rm p1 nlineas p2 passwd.txt;
