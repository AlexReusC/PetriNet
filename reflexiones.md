Las dos estructuras de datos que use para este ejercicio fueron la lista de
adyacencia y la lista de pares. Primero usé la lista de pares porque se me hizo
lo más obvio y mi eleccipón de lista de adyacencia en vez de la matriz es porque
quise usar otra de las estructuras que te da elixir (i.e. la tupla) y no me pareció
natural usarlo en la matriz.

#Lista de adyacencia

Para la lista de adyacencia use una sola tupla que tenía tres partes: el valor, la derecha y el fondo. El valor era simplemente un atom que te indicaba a cual nodo te
estabas refiriendo, la derecha eran los otros átomos a los que apuntaba ese nodo
y el fondo apuntaba al nodo siguiente que repetía la misma idea hasta llegar al final.
Tomando en cuenta el siguiente gráfico

   B-nil
  /
A
  \
   C-nil

Que en lista de adyacencia quedaría así:

A -> B -> C -> nil
|
B -> nil
|
C -> nil

Se podría representar como {A, {B, {C, nil}}, {B, nil, {C, nil, nil}}}

Esa sería una lista de adyacencia que identifica el postSet, para facilitar
las operaciones igualmente cree una lista con los presets. Así trabajé con
dos listas de adyacencia.

#Lista de pares

Para esta es simplemente representar el nodo inicial y al que está apuntando,
simplemente se usaron listas de listas. Así tomando en cuenta el gráfico de arriba
quedaría:
[[A, B], [B, C]]

#Reflexión

La función de fire fue muy parecida en los dos casos, lo unico que cambió fueron
las operaciones de preset y poset: en los pares tenía que buscar a todos con Enum
mientras que en la lista tenía que buscar con un traversal pero solo lo tenía que
buscar una vez porque ahí estaban los presets o el poset.
En mi caso fue más sencilla de utilizar la lista de pares porque aunque no
se muestra tan claramente las operaciones de poset y preset como en la lista de
de adyacencia, las operaciones de Enum hacen facil obtenerlas.
El mayor problema que tuve con la listas de adyacencia fue que tuve que simplificar
las tuplas anidadas a listas, estoy seguro que con una mejor implementación se podría
evitar este problema.
