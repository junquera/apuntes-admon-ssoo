#!/bin/bash

# http://www.nexolinux.com/ficheros-de-usuarios-etcpasswd-y-etcshadow/

USER=$1
# PASSWORD
# S_UID=-1
# S_GID=-1
DIR='/home/'$1
SH='/bin/bash'

if [ ${#USER} -lt 1 ];
then
    echo "[ERROR] Hay que indicar algún nombre para el nuevo usuario"
    exit -1
fi

if [ $UID != 0 ];
then
    echo "Es necesario ser super usuario"
    exit -1
fi

# Comprobar que no existe el nombre del usuario
if [ $(cut -d: -f1 /etc/passwd | grep $USER | wc -w) -gt 0 ];
then
	echo "[ERROR] El usuario $USER ya existe"
	exit -1
fi

# Contraseña
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
HASHED_PASSWORD=$(mkpasswd --method=sha-512 $PASSWORD)
function getNextIdFromFile {
    FILE=$1
    echo $(awk -F: '{uids[$3]=1}END{for(i = 1000; i < 2000; i++) if(!uids[i]){print i; exit;};}' $FILE)
}
S_UID=$(getNextIdFromFile /etc/passwd)
S_GID=$(getNextIdFromFile /etc/group)

echo "/etc/passwd"
echo $USER:x:$S_UID:$S_GID::$DIR:$SH | tee -a /etc/passwd

TIME=$(($(date +%s)/(60*60*24)))
echo "/etc/shadow"
echo $USER:$HASHED_PASSWORD:$TIME:0:99999:7::: | tee -a /etc/shadow

echo "/etc/group"
echo $USER:x:$S_GID: | tee -a /etc/group

echo "Making $DIR"
cp -r /etc/skel $DIR

