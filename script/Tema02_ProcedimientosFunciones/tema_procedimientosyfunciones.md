## TEMA 2 "Procedimientos y Funciones Almacenadas"

### Rudimentos de Procedimientos Transact-SQL 

Un procedimiento almacenado es un *conjunto de instrucciones SQL que se almacena asociado a una base de datos*. Es un objeto que *se crea con la sentencia **CREATE PROCEDURE** y se invoca con la sentencia **EXECUTE***. Un procedimiento puede tener cero o muchos parámetros de entrada y cero o muchos parámetros de salida.

El *lenguaje SQL Server* *consta de una o varias instrucciones Transact-SQL o una referencia a un método de CLR de Microsoft.NET Framework*. Los procedimientos se asemejan a las construcciones de otros lenguajes de programación, porque pueden:
> Aceptar parámetros de entrada y devolver varios valores en forma de parámetros de salida al programa que realiza la llamada
> Contener instrucciones de programación que realicen operaciones en la base de datos, como llamadas a otros procedimientos. 
> Devolver un valor de estado a un programa que realiza una llamada para indicar que la operación se ha realizado correctamente o se han producido errores y cuál fue la causa. 

### Alguna de las ventajas que brinda el uso de Procedimientos son:
> **Tráfico de Red Reducido entre el Cliente y el Servidor:** los comandos de un procedimiento se ejecutan en un único lote de código, reduciendo significativamente el tráfico de red entre el servidor y el cliente porque sólo se envía a través de la red la llamada que va a ejecutar el procedimiento. Sin esta encapsulación del código, cada una de las líneas del script SQL tendría que enviarse en la red. 
> **Mayor Seguridad:** varios usuarios y programas clientes pueden realizar operaciones en los objetos de base de datos subyacentes mediante un procedimiento, aunque los usuarios y los programas no tengan permisos y actividades se llevan a cabo y protegen los objetos de base de datos subyacentes. Esto elimina la necesidad de conceder permisos en cada nivel de objetos y simplifica los niveles de seguridad. 
> **Evitar Suplantaciones de Usuarios:** la cláusula EXECUTE AS puede especificarse en la instrucción CREATE PROCEDURE para habilitar la suplantación de otro usuario o permitir que los usuarios o aplicaciones realicen ciertas actividades en la base de datos sin necesitar contar con permisos directos sobre objetos y comandos subyacentes. 

Al llamar a un procedimiento en la red, solo está visible la llamada que va a ejecutar dicho procedimiento, por tanto *los usuarios malintencionados no pueden ver los nombres de objetos y tablas de la DB incrustados en sus propias instrucciones Transact-SQL ni buscar datos críticos.* 

**El uso de parámetros ayuda a protegerse contra ataques de inyección SQL**, dado que la entrada de éstos se trata como valor literal y no como código ejecutable. El código de cualquier operación de DB redundante es candidato perfecto para la encapsulación de procedimientos, reduciendo inconsistencias y la necesidad de reescribir el código nuevamente. 

De forma predeterminada, *un procedimiento se compila la primera vez que se ejecuta y crea un plan de ejecución que vuelve a crearse en posterior ejecuciones, necesitando así menos tiempo para procesar el procedimiento.* Si hubo cambios importantes en las tablas o datos que referencia el procedimiento, el plan precompilado podría hacer que se ejecutara con mayor lentitud. Volver a crear el procedimiento y forzar un nuevo plan de ejecución mejoraría el rendimiento. 

### Existen diferentes tipos de Procedimientos Almacenados:

>**Definidos por el Usuario:** se puede crear en una DB definida por el usuario o en todas las DB del sistema, excepto en Resource. El procedimiento se puede desarrollar en Transact-SQL o como una referencia a un método de CLR de Microsoft.NET Framework. 

>**Temporales**: forma de procedimientos definidos por el usuario similares a los permanentes, salvo porque se almacenan en tempdb. Existen 2 tipos: locales y globales. Se diferencian entre sí por nombres, visibilidad y disponibilidad. Los locales tiene como primer carácter de sus nombres un solo (#), solo son visibles en la conexión actual de usuario y se eliminan cuando esta se cierra. Los globales tienen dos signos (##), son visibles para cualquier usuario después de su creación, y se eliminan al final de la última sesión en la que se usa el procedimiento. 

>**Sistema**: se incluyen con SQL Server, almacenados físicamente en la DB interna y oculta Resource, y se muestran de forma lógica en el esquema sys de cada DB definida por el sistema y el usuario. La DB msdb también contiene procedimientos almacenados del sistema en el esquema dbo que se usan para programar alertas y trabajos, dado que los procedimientos definidos del sistema empiezan con el prefijo sp_, se recomienda no usar esto cuando se asigne un nombre a los definidos por el usuario. 

*Los parámetros se usan para intercambiar datos entre funciones y procedimientos almacenados y la aplicación o herramienta que los llamó:*

> Los **parámetros de entrada** permiten a quien realiza la llama el pasar un valor de datos a la función o procedimiento almacenado. 
> Los **parámetros de salida** permiten al procedimiento almacenado devolver un valor de datos o variable de cursor a quien realizó la llamada. *Las funciones definidas por el usuario no pueden especificar parámetro de salida. *
> Cada procedimiento almacenado devuelve un código de retorno de tipo entero a quien realiza la llamada. Si el procedimiento almacenado no establece explícitamente un valor para el código de retorno, éste es 0. 

Para que un procedimiento almacenado admita parámetros de entrada se deben declarar variable como parámetros, Su sintaxis es: 

**CREATE PROCEDURE NOMBREPROCEDIMIENTO**
**(@NOMBREPARAMETRO TIPO=VALORPORDEFECTO)**
**AS**
**SENTENCIAS;**

Se aprecia como los parámetros se definen luego del nombre del procedimiento, con el signo @, y son locales al procedimiento mismo, solo existen dentro de este y pueden declararse varios de ellos, separándolos por coma. Para ejecutarlo, se utiliza el comando EXECUTE seguido del nombre del procedimiento y los valores para cada parámetro. 

### Rudimentos de Funciones

*Las funciones en SQL Server son objetos que se utilizan para realizar operaciones y obtener información*. Existen 2 tipos:

> **Funciones del Sistema:** son aquellas que vienen incorporadas con SQL Server, como son las agregadas para valores numéricos, trabajar con fechas, etc. Ejemplos: SUM(), MAX(), DIFFDATE(), etc. 

> **Funciones Definidas por el Usuario:** son establecidas por el usuario durante una sesión y pueden ser utilizadas en consultas. 

Una función almacenada es un *conjunto de instrucciones SQL que se almacena asociado a una base de datos.* Es un objeto que se crea con la sentencia **CREATE FUNCTION** y se invoca con la sentencia **SELECT** o dentro de una **expresión**. Una función puede tener cero o muchos parámetros de entrada y siempre devuelve un valor, asociado al nombre de la función. Como se dijo arriba, una función definida por el usuario no puede asignar parámetros de salida. 

Su sintaxis es: 

**CREATE FUNCTION NOMBREFUNCION (NOMBREDELPARAMETRO TIPODELPARAMETRO)**
**RETURNS TIPODELRETORNO**
**AS**
**BEGIN**
**…**
**…**
**…RETURN …**
**END**

***Los bloques BEGIN y END son obligatorios en una función,*** mientras que el procedimiento almacenado no los requiere si es solo una línea. En una función, ***es obligatorio utilizar los argumentos RETURNS y RETURN***, mientras que en un procedimiento almacenado no es necesario.

**En pocas palabras, un procedimiento almacenado es mucho más flexible para escribir cualquier código que uno desee, mientras que las funciones tienen una estructura y funcionalidad rígidas.**

Algunas características de la relación función-procedimiento:

>***La principal ventaja de una función es que esta puede reutilizarse en código.***

>***Se puede concatenar fácilmente una función con una cadena. Para realizar algo similar con un procedimiento almacenado en SQL, vamos a necesitar una variable de salida en un procedimiento almacenado para poder concatenar la variable de salida con una cadena.***

>***Una ventaja de los procedimientos almacenados es que puede obtener varios parámetros mientras que, en las funciones, solo se puede devolver una variable (función escalar) o una tabla (funciones con valores de tabla).***

>***Es posible invocar funciones dentro de un procedimiento almacenado pero no se puede invocar un procedimiento almacenado dentro de una función. También es posible invocar procedimientos desde un procedimiento. ***

## CONCLUSIONES PARTICULARES DEL TEMA

Hemos vistos que podemos ahorrarnos líneas de código y reutilizar instrucciones mediante el uso de los procedimientos que trae el sistema por defecto y la definición de propios procesos por el usuario. Esto también ayuda a la seguridad e integridad de los datos, así como a la eficiencia en las consultas en la base de datos. Conjunto a esto, aparecen las funciones como otra alternativa pero sin devolucion de parámetros de salida y con un modo de invocación exclusivamente dentro de una consulta SELECT. Además, la posibilidad de utilizar procedimientos uno dentro del otro y vincular funciones a diferentes sesiones y usuarios según sean globales o locales.

