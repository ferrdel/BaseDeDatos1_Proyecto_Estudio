## TEMA 3 "Optimización de Consultas  a través de índices"

En SQLSERVER, los índices son estructuras que se utilizan para mejorar la eficiencia de las consultas a una tabla. Estos índices contienen copias de los datos de la tabla, organizados de una manera que permite que las consultas encuentren los datos más rápidos.
Los índices son importantes en las bases de datos relacionales grandes, donde las consultas pueden ser muy complejas y los tiempos de respuestas de la consulta pueden ser críticos. Al agregar índices, se puede acelerar el proceso de recuperación de datos y mejorar el rendimiento de la base de datos.
### Los tipos de índices que existen en SQL Server: 
> **Clustered Index:** Es un tipo de índice que determina el orden físico de los datos en una tabla. Solo puede haber un índice agrupado por tabla y este ordena la tabla en función de la clave primaria. Es decir, los datos se almacenan en el disco en función de los valores de la columna de la clave primaria.
>> CREATE CLUSTERED INDEX IX_venta_numeroVenta ON [ventas]  ([numeroVenta])
>> GO
> Este ejemplo crea un clustered index en la columna numeroVenta de la tabla ventas, lo que significa que los registros se ordenarán físicamente en la tabla según el registro del numeroVenta. 

> **Nonclustered Index:** A diferencia del índice agrupado, los índices no agrupados no ordenan físicamente la tabla. En su lugar, crean una estructura separada que incluye una copia de la columna de la clave primaria y la columna de índice. Esto permite una búsqueda más rápida de datos en la tabla.
>> CREATE NONCLUSTERED INDEX IX_ventas_numeroVenta ON [ventas] (numeroVenta)
> Este ejemplo crea un nonclustered index en la columna numeroVenta de la tabla ventas, lo que significa que se puede realizar una búsqueda rápida de registros según el número de venta de la venta registrada. 

> **Unique Index:** Este tipo de índice se utiliza para garantizar que no se inserten valores duplicados en una tabla. Es similar a un índice no agrupado, pero solo puede haber un valor único para cada valor de la clave.
>> CREATE UNIQUE INDEX idx_productos_id_producto ON productos (id_producto);
>Este ejemplo crea un unique index en la columna id_producto de la tabla productos, lo que significa que no puede haber dos productos con el mismo código. 

> **Filtered Index:** Este tipo de índice se utiliza para filtrar datos específicos en una tabla. Solo incluyen filas que cumplen con una condición específica. Esto reduce el tamaño del índice y mejora la velocidad de búsqueda de datos.
>> CREATE INDEX idx_ventas_recientes ON ventas (fecha_venta) 
>> WHERE fecha_venta >= '2022-01-01';
>Este ejemplo crea un filtered index en la columna fecha_venta de la tabla ventas, pero sólo para los pedidos realizados después del 1 de enero de 2022. 

> **Full-Text Index:** Este tipo de índice se utiliza para buscar texto completo en una tabla. Permite la búsqueda de palabras clave y frases en lugar de simplemente buscar coincidencias exactas.
>> CREATE FULLTEXT INDEX ON productos (descripcion) 
>> KEY INDEX idx_productos_id_producto;
> Este ejemplo crea un full-text index en la columna descripción de la tabla productos, lo que significa que se puede realizar una búsqueda rápida de productos según la descripción. El índex utiliza la columna id_producto como clave. 

>Es importante conocer los diferentes tipos de índices para poder elegir el más adecuado según las necesidades de la base de datos y mejorar la eficiencia de las consultas.

## CONCLUSIONES PARTICULARES DEL TEMA

Con las pruebas realizadas e información obtenida, pudimos observar que, al implementar índices agrupados, podemos tener mayor tiempo de respuestas y ejecución del motor de base de datos, mejorando el rendimiento de las consultas y reduciendo el tiempo de búsqueda de las mismas al contener un gran volumen de datos o bases de datos extremadamente grandes. Teniendo en Cuenta que la selección de un tipo de índices incorrecto o la aplicación inadecuada, puede tener un impacto negativo en el rendimiento de las bases de datos.
