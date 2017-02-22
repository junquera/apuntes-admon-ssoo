# Teniendo un archivo con DNIs correctos e incorrectos, mostrar los DNIs que no sean válidos (número de 8 dígitos como máximo con una letra sin separación. Por ejemplo, del siguiente archivo debería mostrar por pantalla las líneas que tienen *:
#
# 12312H
# A34234B		*
# 12B1132B		*
# 2467823c
# 123456789A		*

egrep -v -e '^[[:digit:]]{0,8}[[:alpha:]]$' $1;
