= Ejercicios en este taller

1. Ejemplo perifericos
  - NAS
  - RES
  - Interior

2. Ejercicio resolver

  MP generico 16 bits
  - Perif mapeado en _mapa E/S_ (seleccion libre, excepto 0x00000)
  - SO al inicio de mapa mem, ocupa 32K y _requiere contiguos_ otros 32K
  - Bootea en 16K de RAM p / Bios (fin del mapa)
  - Libre eleccion de decodificadores
  - Decodificacion completa
  - Tamaño de bus direcciones = 20

Entonces tenemos dos mapas, uno que seria el principal y otro para el de I/O (E/S (Entrada/Salida))

\

3. Memorias
4. IC -> Decodificadores
$ cases(
  "Glue logic",
  "Placa",
  "E/S (digital)",
  "Cmos/TTL",
  "Logica Inv / convenciones",
) $

5. Conceptos vrios:
  - Ancho de palabra
  - Direccionamiento a byte vs ancho de palabra
  - Mapa E/S (in/out, mov)
  - Arranque del sistema / info


