## TEMA 4 "Triggers"

Un trigger es un procedimiento almacenado en la base de datos que se ejecuta automáticamente cada vez que ocurre un evento especial en la base de datos. Por ejemplo, un desencadenante puede activarse cuando se inserta una fila en una tabla específica o cuando ciertas columnas de la tabla se actualizan.

### La creación de un disparador o trigger se realiza en dos pasos:

> **En primer lugar**, se crea la función disparadora.

> **En segundo lugar**, se crea el propio disparador SQL con el comando CREATE TRIGGER al que se introducen los parámetros para ejecutar la función disparadora.

Por lo general, estos eventos que desencadenan los triggers son cambios en las tablas mediante operaciones de inserción, eliminación y actualización de datos (insert, delete y update).

### Eventos a los que responden los triggers

> **INSERT:** El trigger se activa cuando se inserta una nueva fila sobre la tabla asociada.

> **UPDATE:** El trigger se activa cuando se actualiza una fila sobre la tabla asociada.

> **DELETE:** El trigger se activa cuando se elimina una fila sobre la tabla asociada.

### Clases de Triggers en SQL
> **Triggers DDL (Data Definition Language)**: Esta clase de Triggers se activa en eventos que modifican la estructura de la base de datos (como crear, modificar o eliminar una tabla) o en ciertos eventos relacionados con el servidor, como cambios de seguridad o actualización de eventos estadísticos.

> **Triggers DML (Data Modification Language)**: Esta es la clase más común de Triggers. En este caso, el evento de disparo es una declaración de modificación de datos; podría ser una declaración de inserción, actualización o eliminación en una tabla o vista.

#### A su vez estos últimos tienen diferentes tipos:
> **FOR o AFTER [INSERT, UPDATE, DELETE]**: Estos tipos de Triggers se ejecutan después de completar la instrucción de disparo (inserción, actualización o eliminación).

> **INSTEAD OF [INSERT, UPDATE, DELETE]**: A diferencia del tipo FOR (AFTER), los Triggers INSTEAD OF se ejecutan en lugar de la instrucción de disparo. En otras palabras, este tipo de trigger reemplaza la instrucción de disparo. Son de gran utilidad en los casos en los que es necesario tener integridad referencial entre bases de datos.

### Ventajas:
> Generar automáticamente algunos valores de columna derivados.

> Aplicar la integridad referencial.

> Registro de eventos y almacenamiento de información sobre el acceso a la tabla.

> Auditoría.

> Replicación sincrónica de tablas.

> Imponer autorizaciones de seguridad.

> Prevenir transacciones inválidas.
  
### Utilización
```
CREATE
    [DEFINER = { user | CURRENT_USER }]
    TRIGGER trigger_name
    trigger_time trigger_event
    ON tbl_name FOR EACH ROW
    [trigger_order]
    trigger_body
trigger_time: { BEFORE | AFTER }
trigger_event: { INSERT | UPDATE | DELETE }
trigger_order: { FOLLOWS | PRECEDES } other_trigger_name
