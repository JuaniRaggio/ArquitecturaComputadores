# ArquitecturaComputadores
Notas y ejercicios de Arquitectura de computadoras, principalmente en *procesador Intel x86_64*.

# Compilacion de proyecto

Se puede compilar los archivos typst a pdf usando el siguiente comando:

```sh
typst compile <nombre_archivo.typ>
```

Si no tienen instalado *typst* pueden hacerlo usando su gestor de paquetes de
preferencia.

_Ejemplo en macOS con homebrew_
```sh
brew install typst
```

Pueden ver documentacion de typst [Aca](https://typst.app/docs/)

# Recomendacion personal
El editor *Emacs* para programar en Assembler tiene una integracion nativa excelente y en Melpa hay un paquete que trae soporte para acceder a las instrucciones de la documentacion oficial de tu procesador de preferencia, con capacidad de *buscar instrucciones por nombre* y obtener tanto los *flags que modifica, que registros necesitan ser modificados y un pseudo-codigo mostrando exactamente lo que hace la instruccion*.

# Uso de VM - Lima

