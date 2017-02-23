# Teniendo un archivo con direcciones IP correctas e incorrectas, mostrar las que sean válidas. Por ejemplo, del siguiente archivo debería mostrar por pantalla las líneas que tienen *:
# 
# 200.10.1
# 195.32.12.135	*
# 200.1.300.3	
# 10.10.120.1	*
egrep -e '^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$' $1
