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
