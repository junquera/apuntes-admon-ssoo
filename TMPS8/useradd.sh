#!/bin/bash

# http://www.nexolinux.com/ficheros-de-usuarios-etcpasswd-y-etcshadow/

USER=$1
# PASSWORD
# S_UID=-1
# S_GID=-1
DIR='/home/'$1
SH='/bin/bash'

if [ $(cut -d: -f1 /etc/passwd | grep $USER | wc -w) -gt 0 ];
then
	echo "[ERROR] El usuario $USER ya existe"
	exit -1
fi

while [ ${#PASSWORD} -lt 1 ];
do
	echo "Inserte contraseña: "
	read PASSWORD
	echo "Comprobación de contraseña: "
	read PASSWORD_COMP
	if [ $PASSWORD_COMP != $PASSWORD ];
	then
		echo "[ERROR] Contraseñas no coinciden"
		PASSWORD=''
	fi
done


