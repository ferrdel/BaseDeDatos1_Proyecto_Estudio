    
**Estructura del documento principal:**

# PROYECTO DE ESTUDIO

** Asignatura :** Bases de Datos I (FaCENA-UNNE)

## Comision 2 - GRUPO 1

## Integrantes :
> - Alan, Parras.
> - Julio César, Pintos
> - Giovanni Oscar, Piazza
> - Mauricio Fernando, Ramirez Delgado.

### Año de Cursado: 2024



## CAPÍTULO I: INTRODUCCIÓN

### 1.1 INTRODUCCIÓN

En el contexto actual, la gestión eficiente de bases de datos relacionales seha convertido en un pilar fundamental para el desarrollo de sistemas deinformación robustos y seguros. A medida que las organizaciones manejanvolúmenes crecientes de datos, surge la necesidad de implementarestrategias que no solo garanticen el acceso controlado y seguro a lainformación, sino también optimicen el rendimiento de las consultas yoperaciones realizadas en las bases de datos.

## 1.2 Definición o planteamiento del problema.

En este proyecto se estudiará el manejo de permisos a nivel de usuariosde base de datos, destacando la importancia de establecer políticas deseguridad que definan de manera granular el acceso y la manipulación dedatos.
También, se analizará el uso de procedimientos y funcionesalmacenadas como herramientas de encapsulamiento y reutilización decódigo SQL. Estas estructuras permiten la automatización de procesos,mejoran la consistencia de las operaciones y contribuyen a una mejororganización lógica dentro de la base de datos.
Luego, se abordará la optimización de consultas a través de índices,técnica que se enfoca en mejorar el rendimiento y la velocidad de lasconsultas SQL.
A lo largo de este proyecto, se realizará un análisis teórico y práctico decada uno de estos temas, demostrando cómo su correcta aplicación puedecontribuir significativamente a la eficiencia, seguridad y rendimiento de lossistemas de bases de datos relacionales en entornos académicos yprofesionales.
Todo este análisis se llevará a cabo en base a un estudio de una base dedatos de un sistema de venta de insumos informáticos.

## 1.3 Objetivo del Trabajo Práctico.

El presente proyecto tiene como objetivo explorar y aplicar conceptosavanzados de bases de datos relacionales, abordando tres temáticasclaves: manejo de permisos a nivel de usuarios de base de datos,procedimientos y funciones almacenadas y optimización de consultasa través de índices.

## 1.3.1 Objetivos Generales.
Los objetivos generales es conseguir la correcta interpretación delproblema, en base a su planteamiento teórico con los conceptos de laasignatura para su posterior implementación con software dedicado ala gestión de bases de datos, control de versionado, normalización ydocumentación del proyecto en cuestión, cumpliendo las propuestasdictadas por la cátedra y ofreciendo una solución eficiente alproblema.

## 1.3.2 Objetivos Específicos.
Identificar correctamente el DER asociado al problema con suposterior Diccionario de datos y scripts SQL competentes. Utilizar unesquema de niveles de usuarios por roles para brindar permisos yseguridad.
Mediante la creación de usuarios, implementar diferentes roles deseguridad en la base de datos para asignar permisos específicosrespecto a cada rol.
Consultas SQL para testear el funcionamiento correcto y prevenirfallas o inconsistencias dentro del sistema.
Utilización de índices y su posterior implementación para verificar sucorrecto desempeño y eficiencia en el manejo de la base de datos.
Correcta documentación y control de versionado del equipo en estecaso de estudio para cumplimentar los objetivos


### Definición o planteamiento del problema

Pellentesque interdum aliquam magna sit amet rutrum. Nulla aliquam ligula nec quam iaculis dictum. In cursus aliquam cursus. Nullam a sem vel sapien iaculis finibus. Donec aliquam dictum viverra. Etiam ut orci lacus.

## CAPITULO II: MARCO CONCEPTUAL O REFERENCIAL

### TEMA 1 " ---- "

...

## CAPÍTULO III: METODOLOGÍA SEGUIDA 

...

## CAPÍTULO IV: DESARROLLO DEL TEMA / PRESENTACIÓN DE RESULTADOS 

El Diagrama de Entidad-Relación asociado al caso de estudio planteado es el siguiente:



### Diagrama conceptual (opcional)

```mermaid
erDiagram
marcas  ||..|{  productos  :  
categorias  ||--o{  productos  :  
productos  }|--|{  venta_detalle  :  
ventas  ||--||  venta_detalle  :  
tipo_factura  ||--|{  ventas  :  
clientes  ||--|{  ventas  :  
usuarios  ||--|{  ventas  :  
perfiles  ||--||  usuarios  :  
```

### Diagrama relacional
![diagrama_relacional](https://github.com/ferrdel/BaseDeDatos1_Proyecto_Estudio/tree/main/doc/diagramaBD.jpg)

Y su diccionario de datos asociado resulta, por ejemplo, en el caso de la Tabla Venta_Detalle:

Acceso al documento [PDF](doc/diccionario_datos.pdf) del diccionario de datos.


### Desarrollo TEMA 1 "----"

...

> Acceder a la siguiente carpeta para la descripción completa del tema [scripts-> tema_1](script/tema01_nombre_tema)

### Desarrollo TEMA 2 "----"

... 


## CAPÍTULO V: CONCLUSIONES

...


## BIBLIOGRAFÍA DE CONSULTA

 1. List item
 2. List item
 3. List item
 4. List item
 5. List item

