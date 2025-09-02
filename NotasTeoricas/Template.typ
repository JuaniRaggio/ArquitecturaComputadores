// ====================================
// TEMPLATE DE NOTAS - JUAN IGNACIO RAGGIO
// ====================================

// Configuración del documento
#set document(
  title: "Notas de Clase",
  author: "Juan Ignacio Raggio",
)

// Configuración de la página
#set page(
  paper: "a4",
  margin: (
    top: 2.5cm,
    bottom: 2.5cm,
    left: 2cm,
    right: 2cm,
  ),
  numbering: "1",
  number-align: bottom + right,
  
  // Encabezado
  header: [
    #set text(size: 9pt, fill: gray)
    #grid(
      columns: (1fr, 1fr, 1fr),
      align: (left, center, right),
      [Juan Ignacio Raggio],
      [],
      [#datetime.today().display("[day]/[month]/[year]")]
    )
    #line(length: 100%, stroke: 0.5pt + gray)
  ],
  
  // Pie de página con número
  footer: context [
    #set text(size: 9pt, fill: gray)
    #line(length: 100%, stroke: 0.5pt + gray)
    #v(0.2em)
    #align(center)[
      Página #counter(page).display() de #counter(page).final().first()
    ]
  ]
)

// Configuración de texto
#set text(
  font: "New Computer Modern",  // Puedes cambiar a "Arial", "Times New Roman", etc.
  size: 11pt,
  lang: "es",
  hyphenate: true,
)

// Configuración de párrafos
#set par(
  justify: true,
  leading: 0.65em,
  first-line-indent: 0em,
  spacing: 1.2em,
)

// Configuración de encabezados
#set heading(numbering: "1.1")
#show heading.where(level: 1): set text(size: 16pt, weight: "bold")
#show heading.where(level: 2): set text(size: 14pt, weight: "bold")
#show heading.where(level: 3): set text(size: 12pt, weight: "bold")

// Espaciado antes y después de encabezados
#show heading: it => {
  v(0.5em)
  it
  v(0.3em)
}

// Configuración de listas
#set list(indent: 1em, marker: ("•", "◦", "▪"))
#set enum(indent: 1em, numbering: "1.a.")

// Configuración de código
#show raw.where(block: false): box.with(
  fill: luma(240),
  inset: (x: 3pt, y: 0pt),
  outset: (y: 3pt),
  radius: 2pt,
)

#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: 10pt,
  radius: 4pt,
  width: 100%,
)

// Configuración de links
#show link: underline

// Configuración de ecuaciones
#set math.equation(numbering: "(1)")

// ====================================
// FUNCIONES ÚTILES
// ====================================

// Función para crear una caja de nota/observación
#let nota(contenido) = {
  block(
    fill: rgb("#E3F2FD"),
    stroke: rgb("#1976D2") + 1pt,
    inset: 10pt,
    radius: 4pt,
    width: 100%,
  )[
    #text(weight: "bold", fill: rgb("#1976D2"))[📝 Nota:] #contenido
  ]
}

// Función para crear una caja de advertencia
#let importante(contenido) = {
  block(
    fill: rgb("#FFF3E0"),
    stroke: rgb("#F57C00") + 1pt,
    inset: 10pt,
    radius: 4pt,
    width: 100%,
  )[
    #text(weight: "bold", fill: rgb("#F57C00"))[⚠️ Importante:] #contenido
  ]
}

// Función para crear una caja de definición
#let definicion(termino, contenido) = {
  block(
    fill: rgb("#F3E5F5"),
    stroke: rgb("#7B1FA2") + 1pt,
    inset: 10pt,
    radius: 4pt,
    width: 100%,
  )[
    #text(weight: "bold", fill: rgb("#7B1FA2"))[📚 #termino:] #contenido
  ]
}

// Función para crear una caja de ejemplo
#let ejemplo(contenido) = {
  block(
    fill: rgb("#E8F5E9"),
    stroke: rgb("#388E3C") + 1pt,
    inset: 10pt,
    radius: 4pt,
    width: 100%,
  )[
    #text(weight: "bold", fill: rgb("#388E3C"))[💡 Ejemplo:] #contenido
  ]
}

// ====================================
// PORTADA / INFORMACIÓN DE LA CLASE
// ====================================

// Variables editables para cada documento
#let materia = "Nombre de la Materia"
#let profesor = "Prof. Nombre del Profesor"
#let tema = "Tema de la Clase"
#let clase_numero = "01"
#let cuatrimestre = "2° Cuatrimestre 2024"

// Portada/Encabezado principal
#align(center)[
  #v(1em)
  #text(size: 24pt, weight: "bold")[#materia]
  #v(0.5em)
  #text(size: 16pt)[Clase \##clase_numero: #tema]
  #v(0.5em)
  #text(size: 12pt, fill: gray)[
    #profesor \
    #cuatrimestre \
    #datetime.today().display("[day] de [month repr:long] de [year]")
  ]
  #v(1em)
]

#line(length: 100%, stroke: 1pt)
#v(1em)

// ====================================
// CONTENIDO DE LAS NOTAS
// ====================================

= Introducción

Aquí comienza el contenido de tus notas. Puedes escribir directamente después de esta línea.

= Conceptos Principales

== Subtema 1

Contenido del subtema...

#nota[
  Esto es una nota destacada que puedes usar para información importante.
]

== Subtema 2

Más contenido...

#importante[
  Esto es una advertencia o algo muy importante para recordar.
]

= Ejemplos

#ejemplo[
  Aquí puedes poner ejemplos de los conceptos explicados en clase.
]

= Definiciones

#definicion("Término")[
  Aquí va la definición del término importante.
]

= Ejercicios

+ Primer ejercicio
+ Segundo ejercicio
+ Tercer ejercicio

= Conclusiones

// ====================================
// SECCIÓN DE REFERENCIAS (OPCIONAL)
// ====================================

#pagebreak()
= Referencias

- Referencia 1
- Referencia 2
- Referencia 3
