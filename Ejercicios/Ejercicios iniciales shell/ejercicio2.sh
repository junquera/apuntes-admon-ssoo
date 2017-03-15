# Crear un archivo cuyo nombre sea el añoMesDia (mirar man de la orden date), que contenga los PIDs y nombres de los procesos del usuario root en el sistema
ps -u root > pss;
cut -c1-5 pss | tr -d " " > pids;
cut -c25- pss > psns;
paste pids psns > $(date +"%G%m%d");
rm pss pids psns;
