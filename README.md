# Redpetri

## Pairs

Para la red del primer ejercicio usar Pairs.getNet, del tercero getNetCiclo
del cuarto getTest. Estas devuelven la lista de pares.

La función Pairs.fire recibe tres parametros: la red que se puede conseguir con las
funciones mencionadas arriba, el marcado que es una lista y el elemento al que se
quiere ir que es un átomo. E.g. Pairs.fire(Pairs.getNet, [P0], A)

La función Pairs.enablement recibe la red y el marcado en lista. E.g.
Pairs.enablement(Pairs.getNet, [P1, P2])

La función Pairs.replay recible la red, el marcado inicial y el nombre del archivo.
E.g. Pairs.replay(Pairs.getNet, [P0], "log1.txt")

La función Pairs.reachability_graph recibe la red y el marcado inicial. E.g.
Pairs.reachability_graph(Pairs.getNet, [P0])
