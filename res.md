## Sesión 1

- Metacaracteres `"`, `'`, `\`, `*`, `.`, `$`...

- `?` muestra el estado en el que terminó la última orden.

- Mecanismos de entrecomillado.

- Sustitución de variables y órdenes

    - `$( orden )` = Resultado de ejecución de orden

    - `${ variable }` = Resultado de ejecución de orden contenida en variable

- `alias` / `unalias`

- `locate`
## Sesión 2

- `man`: Páginas de búsqueda

### Redirecciones

Hacemos la redirección de salida de los procesos a archivos utilizando `>`, y la redirección
de entrada de los procesos desde archivos con `<`. Utilizando un identificador, elegimos qué salida o entrada redirigir.

```
stdin (id 0) => ( PROCESO ) => stdout (id 1)
                   ||
                   ====> stderror (id 2)
```

Así, si queremos redirigir sólo la salida de error, podríamos utilizar `2>`. Si queremos, por ejemplo, redirigir la salida de error (con id 2) al mismo sitio que la salida estándar (con id 1), escribiremos: `2>&1`.

Con las tuberías (`|`) redirigimos toda la salida a otro proceso.

### Órdenes, histórico e identificadores de proceso

- `history` muestra el histórico de ordenes identificadas con un índice.

- `![n]` ejecuta la orden `n` del histórico.

- `![orden]` ejecuta la última orden `orden` del histórico.

- `kill`, `ps -aux`, `ps -l`, `pstree`...

- `time [orden]` muestra el tiempo de ejecución de una orden.

- `CTRL+Z` convierte un proceso en zombie. Se puede recuperar con `fg` (para ponerlo en *foreground*) o `bg` (para ponerlo en *background*). Todos estos procesos se pueden listar con `jobs`.


### Find

```
find [modificadores] [ruta] [expresión] [acción]

  modificadores

    -name   Nombre del archivo (o patrón)

    -type   Tipo de archivos

    -size   Tamaño

    ...

    -user   Owner del archivo

  acción

    -exec [orden] Ejecutar la orden indicada por cada línea.

    Para aplicar la operación expecíficamente sobre la salida de find
    utilizaremos {} Terminar siempre -exec con \; Ejemplo:

      # Borrar archivos más grandes de 100 MB
      find . -size +104857600 -exec rm {} \;
```

**CUIDADO** Shell primero expande (`*`, `$`, `.`...) y luego ejecuta. ¡Para buscar algo del tipo `a*` hay que escapar los caracteres especiales (`a
## Sesión 3

### Ejercicio práctico

Buscar todos los archivos modificados en los últimos 8 días:

```
# Resolución
find / -mtime -8 -type f -printf "%AY:%Ab:%Ad %n\n"
```

### ¿Quién está conectado?

- `who`

- `w`   

  Algo así como un who detallado

### Filtros

- `cat [archivo] [**-**]` (este [**-**] indica que continúe leyendo de `stdin`)

  Con la opción `-n` cat muestra el número de las líneas

- `wc`

  Mostrar número de lineas, palabras, caracteres..

- `cut [-d delimitador] [-f campo | -c caracter] [ARCHIVO(s)]`

  Ejemplos:

  ```
  # Extraer los 5 primeros caracteres de file
  cut -c1-5 [file]
  ```

  ```
  # Mostrar el primer campo de un archivo con campos separados por ':'
  cut -d: -f1 /etc/passwd
  ```

- `paste [-d delimitador] [ARCHIVO(s)]`

  Concatena archivos (funcionamiento similar al de `cut`)

- `tr`

  Sustituye caracteres en archivos. Ejemplos:

  ```
  # Borrar aeiou
  tr -d aeiou
  ```

  ```
  # Transforma 'a' en 'A' y 'e' en 'E'
  tr ae AE
  ```

- `more` (yo prefiero `less`)

- `tee [-a] [ARCHIVO(s)]`

  Envía a la salida estandar y a los archivos que reciba como argumento lo que reciba por `stdin`.

- `sort [-n] [-r] [-o salida] [-k POS1[,POS2] | CAMPO[.caracter]] [-t delimitador] [ARCHIVO(s)] [-u]`

  - `-r`  Orden inverso

  - `-n`  Ordenación numérica

  - `-t`, `-k`  Igual que `cut`

  - `-u`  No mostrar lineas duplicadas

- `head`/`tail [-numero_de_lineas]`

  Con la opción `-f`, `tail` mantiene abierto el archivo para observar su evolución.

- `grep [-r] [-e] patrón [-i] [-v] [-n] [-c] [--color] [ARCHIVO(s)]`

  - `-r`  Recursivo

  - `-e`  Marcar el patrón (por ejemplo por si empieza con '-')

  - `-i`  Case insensitive

  - `-v`  Mostrar lineas sin el patrón

  - `-n`  Mostrar número de lineas

  - `-c`  Sólo mostrar conteo de lineas

  - `--color` Destacar coincidencias con color

- `egrep`

  `grep` avanzado (sobre todo para *regexp*). Por ejemplo, sólo con `egrep` funcionan los cuantificadores.

  - `\<-\>` Principio y fin de palabras

  - `[:digit:| ... |:alnum:]`

- `sed [modificadores] orden [ARCHIVO(s)]`
  
  - Modificadores

    `-n`, `-f archivo_de_ordenes`, `-e orden`, `-i extensión`
  
  - Orden
  
    - `DIR[,DIR] acción [ARGUMENTO(s)]`

    - `p` Mostrar resultado

    - `[n]p`  Mostrar linea `n`

    - `-n`  No mostrar lineas procesadas

    - `d` No mostrar (se aplica igual que `p`)
  
    - `s/PATRÓN/SUSTITUCIÓN/g|p|[n]`  Sustituir *PATRÓN* con *SUSTITUCIÓN*. Se pueden sustituir las `/` por cualquier otro caracter si es útil (por ejemplo `s#PATRÓN#SUSTITUCIÓN#g|p|[n]`).
    
    - `y/lista_char_original/lista_char_destino/modificadores`  Hace lo mismo que el comando `tr`
## Sesión 4

### awk (mawk, gawk, sawk...)

`awk [modificadores] [-F separador] regla|-f archivoReglas [-v VARIABLE=VALOR] [ARCHIVO(s)]`

- Reglas

  - `patrón{acción[;otra_acción[;...]]}`

    Sin patrón se aplica la acción a todas las líneas. Sin acción, se imprimen todas las líneas que cumplan el patrn.
    
  - RS
  
    Variable en la que se guarda el separador de registros
  
  - FS
  
    Variable en la que se guarda el separador de campos. Por defecto el separador es el espacio en blanco ' '.
    
  - NF
  
    Número de campos del registro actual
    
  - NR
  
    Número de registros (lineas) procesados
  
  - Campos
  
    `$0`  Línea completa (registro completo)
    
    `$1`, `$2`, `$3`, ... Identificando os registros
    
  - Ejemplo
  
  ``` sh
  $ ls -l | awk -F' ' '{print $1}'
  total
  -rw-rw----
  -rw-rw----
  -rwxrwx---
  -rwxrwx---
  -rw-rw----
  -rw-rw----
  -rw-rw----
  -rw-r-----
  -rw-rw----
  -rw-rw----
  ```
    
- Patrones

  - **BEGIN** Acciones a realizar antes del procesado
  
  - **END** Acciones a realizar tras el procesado
  
  - /*expresión_regular*/
  
  - Expresión relacional (`3<5{REGLA}`)
  
  - Expresión lógica (sólo AND y OR: `patrón1&&patrón2`, `patrón1||patrón2`)
  
  > **CUIDADO** ¡Nunca poner espaciones entre los patrones y las reglas!
  
  - Ejemplo:
  
  ``` sh
  $ ls -l | awk -F' ' 'BEGIN{print "Primer campo de ls -l {"}{print "\t"$1}END{print "}"}'
  Primer campo de ls -l {
     total
     -rw-rw----
     -rw-rw----
     -rwxrwx---
     -rwxrwx---
     -rw-rw----
     -rw-rw----
     -rw-rw----
     -rw-r-----
     -rw-rw----
     -rw-rw----
  }
  ```

- Variables

  *awk* interpreta cualquier cosa que no esté entre comillas dentro de las reglas como una variable. Por ejemplo:
  
  ``` sh
  $ ls -l | awk -F' ' '{guion="#"; print guion" "$1}'
  # total
  # -rw-rw----
  # -rw-rw----
  # -rwxrwx---
  # -rwxrwx---
  # -rw-rw----
  # -rw-rw----
  # -rw-rw----
  # -rw-r-----
  # -rw-rw----
  # -rw-rw----
  ```
  
- Archivos de reglas

  Es una buena práctica escribir las reglas complejas siguiendo reglas de estilo de programación. Por ejemplo, la orden `ls -l | awk -F' ' 'BEGIN{print "Primer campo de ls -l {"}{print "\t"$1}END{print "}"}'` estaría mejor escrito así: `ls -l | awk -F' ' -f reglas.awk`
  
  ``` awk
  # reglas.awk
  BEGIN{
    print "Primer campo de ls -l {"
  }
  {
    print "\t"$1
  }
  END{
    print "}"
  }
  ```
  
- Arrays asociativos (*maps* de otros lenguajes)

  `array[blanco]=4` nos movemos dentro con el operador `in`

> El resto de la sesión se resume con los ejercicios `ejercicios iniciales awk` de la carpeta *Ejercicios* 
## Sesión 5

Hay muchos comandos útiles: `diff` (diferencias entre archivos), `vimdiff` (`diff` mostrado en `vim`), `cal` (mostrar calendario), `bc` (calculadora)...

`script` - Graba todas las órdenes de la sesión y los resultados de dichas órdenes.

### Scripting

Para ejecutar un shell script utilizaremos `bash`. Así no lo ejecutamos sobre la shell que tenemos abierta y la "protegemos" (a diferencia de lo que ocurriría con `./script`). Con `bash -x` además del script mostramos qué linea estamos ejecutando:

```
adminssoo@LE05P18:~/S5$ bash programaShell 
programaShell  typescript
  PID TTY          TIME CMD
15076 pts/0    00:00:00 bash
15219 pts/0    00:00:00 bash
15221 pts/0    00:00:00 ps
```

```
adminssoo@LE05P18:~/S5$ bash -x programaShell 
+ ls
programaShell  typescript
+ ps
  PID TTY          TIME CMD
15076 pts/0    00:00:00 bash
15224 pts/0    00:00:00 bash
15226 pts/0    00:00:00 ps
+ exit
```

Para definir en qué shell se va a ejecutar un script lo definimos en la primera línea:

```
#!/bin/bash 
```

Podemos poner cualquier intérprete:

```
#!/bin/sh 
#!/usr/bin/python 
#! ...
```

o incluso añadir modificadores.

```
#!/bin/bash -x
```

También existe el modo de ejecución`. programaShell` que ejecuta todos los procesos sobre la shell (por ejemplo, podríamos modificar el path, variables...). Esto es útil para inicializar una shell, combinar shellScripts...

> **APUNTAR** La variable $PS1 cambia el prompt

#### Argumentos

Los argumentos de un shell script se leen con **$***[n]* (siendo *n* el número de argumento). Con `$*` obtenemos todos los argumentos. Con `$0` accedemos al nombre del ejecutable. Con `$#` obtenemos el número de argumentos introducidos.
Hay que trabajar con llaves si queremos indicar un argumento cuyo índice tenga más de una cifra o dará error:

```
adminssoo@LE05P18:~$ cat ejemplo1.sh 
#!/bin/bash
echo $10
echo $9
echo $8
echo ...
echo $1
adminssoo@LE05P18:~$ . ejemplo1.sh uno dos tres cuatro cinco seis siete ocho nueve diez
uno0
nueve
ocho
...
uno
adminssoo@LE05P18:~$ cat ejemplo2.sh 
#!/bin/bash
echo ${10}
echo $9
echo $8
echo ...
echo $1
adminssoo@LE05P18:~$ . ejemplo2.sh uno dos tres cuatro cinco seis siete ocho nueve diez
diez
nueve
ocho
...
uno
```

- `shift [n]` 

Desplaza los argumentos (contenidos en un array) a la izquierda (perdiéndose el primero). Utilizamos esto para recorrer los argumentos (no siempre se puede utilizar un `for`). El parámetro `n` indica cuántas veces tiene que ejecutarse `shift`.

- Valores por defecto

Cuando una variable puede quedar vacía, tenemos que proteger nuestro programa contra errores indicando un valor por defecto: `${VARIABLE-ValorPorDefecto}`

```
adminssoo@LE05P18:~$ cat test.sh 
#!/bin/bash
echo 'Arg ( $1 ) : '$1
echo 'Arg. protegido ( ${1-Vacío} ): '${1-Vacío}
adminssoo@LE05P18:~$ . test.sh 
Arg ( $1 ) : 
Arg. protegido ( ${1-Vacío} ): Vacío
```

Con `${#VARIBALE}` obtenemos el número de la variable.

- Arrays

```
$ ARRAY=(uno dos tres)
$ echo $ARRAY
uno
$ echo $ARRAY[|]
uno[1]  
$ echo ${ARRAY[1]}
dos
$ echo ${ARRAY[*]}
uno dos tres
```

Uso de `@`:

```
$ cat test.sh 
#!/bin/bash
echo "Argumentos: "${#}
$ bash test.sh ${ARRAY[*]}
Argumentos: 3
$ bash test.sh "${ARRAY[*]}"
Argumentos: 1
$ bash test.sh "${ARRAY[@]}"
Argumentos: 3
# ¿Qué utilidad tiene entonces, si es igual que * sin comillas?
$ ARRAY=(uno dos "otro numero")
$ bash test.sh ${ARRAY[*]}
Argumentos: 4
$ bash test.sh "${ARRAY[@]}"
Argumentos: 3
```

### Entrada / Salida

- Entrada

  - `read [-u fd] [-d DELIM_FIN] [-n NUMVAR] [-t TIMEOUT] [-p PROMPT] [VARIABLE]`

  Lee la entrada estándar y guarda los datos en la variable (por defecto) `REPLY`.

  - `p` Indicar al usuario un mensaje.

  - `d` Dejar de leer al leer entrada indicada.

  - `t` Dejar de leer al pasar un tiempo sin recibir nada.

  - `n` Máximo número de caracteres.
  
- Salida

  - `echo`
  
  - `cat << FIN` Muestra todo lo que tenga hasta encontrar una línea con la palabra indicada (en este caso, *FIN*).
  
    ```
    $ cat << FIN > test
    > prueba
    > sin
    > FIN
    $ cat test
    prueba
    sin
    ```

    > **BUSCAR** Variable `cat <<- FIN`
    
  - `printf`  Imprimir con formato
    
    ```
    $ printf "%s%d\n" hi 5
    hi5
    ```
#!/bin/bash
# Ejercicio 1

if [ $# -lt 2 ]; then
	echo "[ERROR]	Mínimo dos argumentos";
else
	case $1 in
		'for');;
		'while');;
		'until');;
		*)
			echo "[ERROR]	El primer argumento debe ser for, while o until"
			exit -1
		;;
	esac

	shift
	while [ $# -gt 0 ];
	do
		echo $1
		shift
	done
fi
#!/bin/bash
# Ejercicio 2

if [ $# -lt 1 ]; then
	echo "[ERROR]	Mínimo un argumentos";
else
	select ORD in 'for' 'while' 'until' 'exit'
	do
		case $ORD in
			'for')
				break
			;;
			'while')
				break
			;;
			'until')
				break
			;;
			'exit')
			;;
		esac
	done
	while [ $# -gt 0 ];
	do
		echo $1
		shift
	done
fi
#!/bin/bash
# Ejercicio 3

myFor(){
	return
}

myWhile(){
	return
}

myUntil(){
	return
}

myExit(){
	exit 0;
}

main(){
	select ORD in 'for' 'while' 'until' 'exit'
	do
		case $ORD in
			'for')
				myFor $@
				break
			;;
			'while')
				myWhile $@
				break
			;;
			'until')
				myUntil $@
				break
			;;
			'exit')
				myExit
			;;
		esac
	done
	while [ $# -gt 0 ];
	do
		echo $1
		shift
	done
}
if [ $# -lt 1 ]; then
	echo "[ERROR]	Mínimo un argumentos";
else
	while [ 1 ]
	do
		main $@
	done;
fi
#!/bin/bash
# Ejercicio 4

ORDENES=('for' 'while' 'until' 'exit')
myFor(){
	return
}

myWhile(){
	return
}

myUntil(){
	return
}

myExit(){
	exit 0;
}

main(){
	select ORD in ${ORDENES[@]}
	do
		case $ORD in
			'for')
				myFor $@
				break
			;;
			'while')
				myWhile $@
				break
			;;
			'until')
				myUntil $@
				break
			;;
			'exit')
				myExit
			;;
		esac
	done
	while [ $# -gt 0 ];
	do
		echo $1
		shift
	done
}
if [ $# -lt 1 ]; then
	echo "[ERROR]	Mínimo un argumentos";
else
	while [ 1 ]
	do
		main $@
	done;
fi
## Sesión 1

- Metacaracteres `"`, `'`, `\`, `*`, `.`, `$`...

- `?` muestra el estado en el que terminó la última orden.

- Mecanismos de entrecomillado.

- Sustitución de variables y órdenes

    - `$( orden )` = Resultado de ejecución de orden

    - `${ variable }` = Resultado de ejecución de orden contenida en variable

- `alias` / `unalias`

- `locate`
## Sesión 2

- `man`: Páginas de búsqueda

### Redirecciones

Hacemos la redirección de salida de los procesos a archivos utilizando `>`, y la redirección
de entrada de los procesos desde archivos con `<`. Utilizando un identificador, elegimos qué salida o entrada redirigir.

```
stdin (id 0) => ( PROCESO ) => stdout (id 1)
                   ||
                   ====> stderror (id 2)
```

Así, si queremos redirigir sólo la salida de error, podríamos utilizar `2>`. Si queremos, por ejemplo, redirigir la salida de error (con id 2) al mismo sitio que la salida estándar (con id 1), escribiremos: `2>&1`.

Con las tuberías (`|`) redirigimos toda la salida a otro proceso.

### Órdenes, histórico e identificadores de proceso

- `history` muestra el histórico de ordenes identificadas con un índice.

- `![n]` ejecuta la orden `n` del histórico.

- `![orden]` ejecuta la última orden `orden` del histórico.

- `kill`, `ps -aux`, `ps -l`, `pstree`...

- `time [orden]` muestra el tiempo de ejecución de una orden.

- `CTRL+Z` convierte un proceso en zombie. Se puede recuperar con `fg` (para ponerlo en *foreground*) o `bg` (para ponerlo en *background*). Todos estos procesos se pueden listar con `jobs`.


### Find

```
find [modificadores] [ruta] [expresión] [acción]

  modificadores

    -name   Nombre del archivo (o patrón)

    -type   Tipo de archivos

    -size   Tamaño

    ...

    -user   Owner del archivo

  acción

    -exec [orden] Ejecutar la orden indicada por cada línea.

    Para aplicar la operación expecíficamente sobre la salida de find
    utilizaremos {} Terminar siempre -exec con \; Ejemplo:

      # Borrar archivos más grandes de 100 MB
      find . -size +104857600 -exec rm {} \;
```

**CUIDADO** Shell primero expande (`*`, `$`, `.`...) y luego ejecuta. ¡Para buscar algo del tipo `a*` hay que escapar los caracteres especiales (`a
## Sesión 3

### Ejercicio práctico

Buscar todos los archivos modificados en los últimos 8 días:

```
# Resolución
find / -mtime -8 -type f -printf "%AY:%Ab:%Ad %n\n"
```

### ¿Quién está conectado?

- `who`

- `w`   

  Algo así como un who detallado

### Filtros

- `cat [archivo] [**-**]` (este [**-**] indica que continúe leyendo de `stdin`)

  Con la opción `-n` cat muestra el número de las líneas

- `wc`

  Mostrar número de lineas, palabras, caracteres..

- `cut [-d delimitador] [-f campo | -c caracter] [ARCHIVO(s)]`

  Ejemplos:

  ```
  # Extraer los 5 primeros caracteres de file
  cut -c1-5 [file]
  ```

  ```
  # Mostrar el primer campo de un archivo con campos separados por ':'
  cut -d: -f1 /etc/passwd
  ```

- `paste [-d delimitador] [ARCHIVO(s)]`

  Concatena archivos (funcionamiento similar al de `cut`)

- `tr`

  Sustituye caracteres en archivos. Ejemplos:

  ```
  # Borrar aeiou
  tr -d aeiou
  ```

  ```
  # Transforma 'a' en 'A' y 'e' en 'E'
  tr ae AE
  ```

- `more` (yo prefiero `less`)

- `tee [-a] [ARCHIVO(s)]`

  Envía a la salida estandar y a los archivos que reciba como argumento lo que reciba por `stdin`.

- `sort [-n] [-r] [-o salida] [-k POS1[,POS2] | CAMPO[.caracter]] [-t delimitador] [ARCHIVO(s)] [-u]`

  - `-r`  Orden inverso

  - `-n`  Ordenación numérica

  - `-t`, `-k`  Igual que `cut`

  - `-u`  No mostrar lineas duplicadas

- `head`/`tail [-numero_de_lineas]`

  Con la opción `-f`, `tail` mantiene abierto el archivo para observar su evolución.

- `grep [-r] [-e] patrón [-i] [-v] [-n] [-c] [--color] [ARCHIVO(s)]`

  - `-r`  Recursivo

  - `-e`  Marcar el patrón (por ejemplo por si empieza con '-')

  - `-i`  Case insensitive

  - `-v`  Mostrar lineas sin el patrón

  - `-n`  Mostrar número de lineas

  - `-c`  Sólo mostrar conteo de lineas

  - `--color` Destacar coincidencias con color

- `egrep`

  `grep` avanzado (sobre todo para *regexp*). Por ejemplo, sólo con `egrep` funcionan los cuantificadores.

  - `\<-\>` Principio y fin de palabras

  - `[:digit:| ... |:alnum:]`

- `sed [modificadores] orden [ARCHIVO(s)]`
  
  - Modificadores

    `-n`, `-f archivo_de_ordenes`, `-e orden`, `-i extensión`
  
  - Orden
  
    - `DIR[,DIR] acción [ARGUMENTO(s)]`

    - `p` Mostrar resultado

    - `[n]p`  Mostrar linea `n`

    - `-n`  No mostrar lineas procesadas

    - `d` No mostrar (se aplica igual que `p`)
  
    - `s/PATRÓN/SUSTITUCIÓN/g|p|[n]`  Sustituir *PATRÓN* con *SUSTITUCIÓN*. Se pueden sustituir las `/` por cualquier otro caracter si es útil (por ejemplo `s#PATRÓN#SUSTITUCIÓN#g|p|[n]`).
    
    - `y/lista_char_original/lista_char_destino/modificadores`  Hace lo mismo que el comando `tr`
## Sesión 4

### awk (mawk, gawk, sawk...)

`awk [modificadores] [-F separador] regla|-f archivoReglas [-v VARIABLE=VALOR] [ARCHIVO(s)]`

- Reglas

  - `patrón{acción[;otra_acción[;...]]}`

    Sin patrón se aplica la acción a todas las líneas. Sin acción, se imprimen todas las líneas que cumplan el patrn.
    
  - RS
  
    Variable en la que se guarda el separador de registros
  
  - FS
  
    Variable en la que se guarda el separador de campos. Por defecto el separador es el espacio en blanco ' '.
    
  - NF
  
    Número de campos del registro actual
    
  - NR
  
    Número de registros (lineas) procesados
  
  - Campos
  
    `$0`  Línea completa (registro completo)
    
    `$1`, `$2`, `$3`, ... Identificando os registros
    
  - Ejemplo
  
  ``` sh
  $ ls -l | awk -F' ' '{print $1}'
  total
  -rw-rw----
  -rw-rw----
  -rwxrwx---
  -rwxrwx---
  -rw-rw----
  -rw-rw----
  -rw-rw----
  -rw-r-----
  -rw-rw----
  -rw-rw----
  ```
    
- Patrones

  - **BEGIN** Acciones a realizar antes del procesado
  
  - **END** Acciones a realizar tras el procesado
  
  - /*expresión_regular*/
  
  - Expresión relacional (`3<5{REGLA}`)
  
  - Expresión lógica (sólo AND y OR: `patrón1&&patrón2`, `patrón1||patrón2`)
  
  > **CUIDADO** ¡Nunca poner espaciones entre los patrones y las reglas!
  
  - Ejemplo:
  
  ``` sh
  $ ls -l | awk -F' ' 'BEGIN{print "Primer campo de ls -l {"}{print "\t"$1}END{print "}"}'
  Primer campo de ls -l {
     total
     -rw-rw----
     -rw-rw----
     -rwxrwx---
     -rwxrwx---
     -rw-rw----
     -rw-rw----
     -rw-rw----
     -rw-r-----
     -rw-rw----
     -rw-rw----
  }
  ```

- Variables

  *awk* interpreta cualquier cosa que no esté entre comillas dentro de las reglas como una variable. Por ejemplo:
  
  ``` sh
  $ ls -l | awk -F' ' '{guion="#"; print guion" "$1}'
  # total
  # -rw-rw----
  # -rw-rw----
  # -rwxrwx---
  # -rwxrwx---
  # -rw-rw----
  # -rw-rw----
  # -rw-rw----
  # -rw-r-----
  # -rw-rw----
  # -rw-rw----
  ```
  
- Archivos de reglas

  Es una buena práctica escribir las reglas complejas siguiendo reglas de estilo de programación. Por ejemplo, la orden `ls -l | awk -F' ' 'BEGIN{print "Primer campo de ls -l {"}{print "\t"$1}END{print "}"}'` estaría mejor escrito así: `ls -l | awk -F' ' -f reglas.awk`
  
  ``` awk
  # reglas.awk
  BEGIN{
    print "Primer campo de ls -l {"
  }
  {
    print "\t"$1
  }
  END{
    print "}"
  }
  ```
  
- Arrays asociativos (*maps* de otros lenguajes)

  `array[blanco]=4` nos movemos dentro con el operador `in`

> El resto de la sesión se resume con los ejercicios `ejercicios iniciales awk` de la carpeta *Ejercicios* 
## Sesión 5

Hay muchos comandos útiles: `diff` (diferencias entre archivos), `vimdiff` (`diff` mostrado en `vim`), `cal` (mostrar calendario), `bc` (calculadora)...

`script` - Graba todas las órdenes de la sesión y los resultados de dichas órdenes.

### Scripting

Para ejecutar un shell script utilizaremos `bash`. Así no lo ejecutamos sobre la shell que tenemos abierta y la "protegemos" (a diferencia de lo que ocurriría con `./script`). Con `bash -x` además del script mostramos qué linea estamos ejecutando:

```
adminssoo@LE05P18:~/S5$ bash programaShell 
programaShell  typescript
  PID TTY          TIME CMD
15076 pts/0    00:00:00 bash
15219 pts/0    00:00:00 bash
15221 pts/0    00:00:00 ps
```

```
adminssoo@LE05P18:~/S5$ bash -x programaShell 
+ ls
programaShell  typescript
+ ps
  PID TTY          TIME CMD
15076 pts/0    00:00:00 bash
15224 pts/0    00:00:00 bash
15226 pts/0    00:00:00 ps
+ exit
```

Para definir en qué shell se va a ejecutar un script lo definimos en la primera línea:

```
#!/bin/bash 
```

Podemos poner cualquier intérprete:

```
#!/bin/sh 
#!/usr/bin/python 
#! ...
```

o incluso añadir modificadores.

```
#!/bin/bash -x
```

También existe el modo de ejecución`. programaShell` que ejecuta todos los procesos sobre la shell (por ejemplo, podríamos modificar el path, variables...). Esto es útil para inicializar una shell, combinar shellScripts...

> **APUNTAR** La variable $PS1 cambia el prompt

#### Argumentos

Los argumentos de un shell script se leen con **$***[n]* (siendo *n* el número de argumento). Con `$*` obtenemos todos los argumentos. Con `$0` accedemos al nombre del ejecutable. Con `$#` obtenemos el número de argumentos introducidos.
Hay que trabajar con llaves si queremos indicar un argumento cuyo índice tenga más de una cifra o dará error:

```
adminssoo@LE05P18:~$ cat ejemplo1.sh 
#!/bin/bash
echo $10
echo $9
echo $8
echo ...
echo $1
adminssoo@LE05P18:~$ . ejemplo1.sh uno dos tres cuatro cinco seis siete ocho nueve diez
uno0
nueve
ocho
...
uno
adminssoo@LE05P18:~$ cat ejemplo2.sh 
#!/bin/bash
echo ${10}
echo $9
echo $8
echo ...
echo $1
adminssoo@LE05P18:~$ . ejemplo2.sh uno dos tres cuatro cinco seis siete ocho nueve diez
diez
nueve
ocho
...
uno
```

- `shift [n]` 

Desplaza los argumentos (contenidos en un array) a la izquierda (perdiéndose el primero). Utilizamos esto para recorrer los argumentos (no siempre se puede utilizar un `for`). El parámetro `n` indica cuántas veces tiene que ejecutarse `shift`.

- Valores por defecto

Cuando una variable puede quedar vacía, tenemos que proteger nuestro programa contra errores indicando un valor por defecto: `${VARIABLE-ValorPorDefecto}`

```
adminssoo@LE05P18:~$ cat test.sh 
#!/bin/bash
echo 'Arg ( $1 ) : '$1
echo 'Arg. protegido ( ${1-Vacío} ): '${1-Vacío}
adminssoo@LE05P18:~$ . test.sh 
Arg ( $1 ) : 
Arg. protegido ( ${1-Vacío} ): Vacío
```

Con `${#VARIBALE}` obtenemos el número de la variable.

- Arrays

```
$ ARRAY=(uno dos tres)
$ echo $ARRAY
uno
$ echo $ARRAY[|]
uno[1]  
$ echo ${ARRAY[1]}
dos
$ echo ${ARRAY[*]}
uno dos tres
```

Uso de `@`:

```
$ cat test.sh 
#!/bin/bash
echo "Argumentos: "${#}
$ bash test.sh ${ARRAY[*]}
Argumentos: 3
$ bash test.sh "${ARRAY[*]}"
Argumentos: 1
$ bash test.sh "${ARRAY[@]}"
Argumentos: 3
# ¿Qué utilidad tiene entonces, si es igual que * sin comillas?
$ ARRAY=(uno dos "otro numero")
$ bash test.sh ${ARRAY[*]}
Argumentos: 4
$ bash test.sh "${ARRAY[@]}"
Argumentos: 3
```

### Entrada / Salida

- Entrada

  - `read [-u fd] [-d DELIM_FIN] [-n NUMVAR] [-t TIMEOUT] [-p PROMPT] [VARIABLE]`

  Lee la entrada estándar y guarda los datos en la variable (por defecto) `REPLY`.

  - `p` Indicar al usuario un mensaje.

  - `d` Dejar de leer al leer entrada indicada.

  - `t` Dejar de leer al pasar un tiempo sin recibir nada.

  - `n` Máximo número de caracteres.
  
- Salida

  - `echo`
  
  - `cat << FIN` Muestra todo lo que tenga hasta encontrar una línea con la palabra indicada (en este caso, *FIN*).
  
    ```
    $ cat << FIN > test
    > prueba
    > sin
    > FIN
    $ cat test
    prueba
    sin
    ```

    > **BUSCAR** Variable `cat <<- FIN`
    
  - `printf`  Imprimir con formato
    
    ```
    $ printf "%s%d\n" hi 5
    hi5
    ```
### Ejercicios T6

1) Crear un shell script que muestre en líneas separadas cada uno de los parámetros que reciba. Teniendo en cuenta que:

- Recibe un primer parámetro (que debe ser for, while o until) que indica la orden a utilizar para generar la salidad del resto de parámetros.

- Comprueba que los argumentos son correctos (al menos dos argumentos y el primero es una de las órdenes correctas)

- Debe utilizar un case para seleccionar el código a ejecutar (con for, con while o con until) y no utilizar funciones.

``` bash
$> miScript for uno dos tres
uno
dos
tres
```

2) Añadir y modificar lo necesario al script anterior para utilizar la orden select en lugar del argumento 1 para indicar la orden a a utilizar (while, for o until), incluyendo una opción para finalizar

3) Utilice funciones para permitir que el script del apartado 2 se ejecute correctamente varias veces seguidas sin finalizar

4) Generalice el script del apartado 3 para que el nombre de las opciones esté en un array declarado al comienzo del tipo ORDENES=(for while until finalizar).

5) Crear un nuevo script que muestre la dirección de red a partir de una dirección IP y su máscara de red. Es necesario crear una función que calcule solamente un byte de la dirección de red resultante. El script recibirá la dirección IP y la máscara como argumentos en la llamada.
#!/bin/bash
# Ejercicio 1

if [ $# -lt 2 ]; then
	echo "[ERROR]	Mínimo dos argumentos";
else
	case $1 in
		'for');;
		'while');;
		'until');;
		*)
			echo "[ERROR]	El primer argumento debe ser for, while o until"
			exit -1
		;;
	esac

	shift
	while [ $# -gt 0 ];
	do
		echo $1
		shift
	done
fi
#!/bin/bash
# Ejercicio 2

if [ $# -lt 1 ]; then
	echo "[ERROR]	Mínimo un argumentos";
else
	select ORD in 'for' 'while' 'until' 'exit'
	do
		case $ORD in
			'for')
				break
			;;
			'while')
				break
			;;
			'until')
				break
			;;
			'exit')
			;;
		esac
	done
	while [ $# -gt 0 ];
	do
		echo $1
		shift
	done
fi
#!/bin/bash
# Ejercicio 3

myFor(){
	return
}

myWhile(){
	return
}

myUntil(){
	return
}

myExit(){
	exit 0;
}

main(){
	select ORD in 'for' 'while' 'until' 'exit'
	do
		case $ORD in
			'for')
				myFor $@
				break
			;;
			'while')
				myWhile $@
				break
			;;
			'until')
				myUntil $@
				break
			;;
			'exit')
				myExit
			;;
		esac
	done
	while [ $# -gt 0 ];
	do
		echo $1
		shift
	done
}
if [ $# -lt 1 ]; then
	echo "[ERROR]	Mínimo un argumentos";
else
	while [ 1 ]
	do
		main $@
	done;
fi
#!/bin/bash
# Ejercicio 4

ORDENES=('for' 'while' 'until' 'exit')
myFor(){
	return
}

myWhile(){
	return
}

myUntil(){
	return
}

myExit(){
	exit 0;
}

main(){
	select ORD in ${ORDENES[@]}
	do
		case $ORD in
			'for')
				myFor $@
				break
			;;
			'while')
				myWhile $@
				break
			;;
			'until')
				myUntil $@
				break
			;;
			'exit')
				myExit
			;;
		esac
	done
	while [ $# -gt 0 ];
	do
		echo $1
		shift
	done
}
if [ $# -lt 1 ]; then
	echo "[ERROR]	Mínimo un argumentos";
else
	while [ 1 ]
	do
		main $@
	done;
fi
## Sesión 6

Resumen de la sesión con los ejercicios del directorio *S6*
## Sesión 6

Resumen de la sesión con los ejercicios del directorio *S6*
## Sesión 8

> **¡INCOMPLETO!** Recopilación de los conceptos tratados en la sesión 8

- su

- Permisos 'rwx'

- `umask`

### Creación de usuarios

Recopilada en el script [`useradd.sh`](./S8/useradd.sh)
