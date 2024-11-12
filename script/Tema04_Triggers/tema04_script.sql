-- 1. Triggers de auditoría para UPDATE y DELETE. Creacion de tabla auxiliar de auditorias
CREATE TABLE [dbo].[auditoria] (
    [id_auditoria] INT PRIMARY KEY IDENTITY(1,1),
    [tabla] VARCHAR(50) NOT NULL,
    [tipo_operacion] VARCHAR(10) NOT NULL, -- 'UPDATE' o 'DELETE'
    [datos_anteriores] NVARCHAR(MAX) NOT NULL,
    [fecha_operacion] DATETIME DEFAULT GETDATE(),
    [usuario] VARCHAR(50) DEFAULT SYSTEM_USER
);

--1.1. Creacion de trigger para update
-- Este trigger tiene el objetivo de registrar los cambios en una tabla de auditoría.
CREATE TRIGGER trg_auditoria_update
ON [dbo].[clientes] -- Especifica la tabla sobre la cual se aplicará el trigger. En este caso, 'clientes'.
AFTER UPDATE
AS
BEGIN
    -- Desactiva el envío de mensajes adicionales, para optimizar el rendimiento
    SET NOCOUNT ON;

    -- Inserta un nuevo registro en la tabla de auditoría cada vez que ocurre una actualización en la tabla 'clientes'.
    INSERT INTO auditoria (tabla, tipo_operacion, datos_anteriores, fecha_operacion, usuario)
    
    -- Realiza una selección de los datos anteriores a la actualización desde la tabla virtual 'deleted', que almacena
    -- los valores originales antes de ser actualizados en la operación.
    SELECT 
        'clientes' AS tabla, -- Especifica el nombre de la tabla afectada, en este caso, 'clientes'.
        'UPDATE' AS tipo_operacion, -- Define el tipo de operación como 'UPDATE', para indicar que fue una actualización.
        
        -- Concadena los valores previos de cada columna en un solo campo de texto.
        -- Este campo, 'datos_anteriores', contendrá la información antes de la actualización.
        CONCAT(
            'dni_c:', CAST(d.dni_c AS NVARCHAR), ', ', -- Convierte el campo 'dni_c' a texto y lo concatena con el resto.
            'nombre_c:', d.nombre_c, ', ',              -- Concatena el campo 'nombre_c'.
            'apellido:', d.apellido, ', ',              -- Concatena el campo 'apellido'.
            'fechaNac_c:', CAST(d.fechaNac_c AS NVARCHAR), ', ', -- Concatena 'fechaNac_c' convirtiéndolo a texto.
            'email:', d.email, ', ',                    -- Concatena el campo 'email'.
            'direccion:', d.direccion, ', ',            -- Concatena el campo 'direccion'.
            'telefono:', CAST(d.telefono AS NVARCHAR), ', ', -- Concatena 'telefono' convirtiéndolo a texto.
            'eliminado:', d.eliminado                   -- Concatena el campo 'eliminado'.
        ) AS datos_anteriores, -- El resultado final se almacena en el campo 'datos_anteriores'.

        GETDATE() AS fecha_operacion, -- Registra la fecha y hora en que se realizó la operación.
        SYSTEM_USER AS usuario        -- Registra el usuario del sistema que realizó la operación.
    
    FROM deleted d; -- La información se obtiene de la tabla virtual 'deleted', que contiene los datos anteriores.

END;
GO -- Finaliza el script del trigger.


--1.2. Creacion de trigger para delete
-- Este trigger tiene el objetivo de registrar los datos eliminados en una tabla de auditoría.
CREATE TRIGGER trg_auditoria_delete
ON [dbo].[clientes] -- Especifica la tabla sobre la cual se aplicará el trigger. En este caso, 'clientes'.
AFTER DELETE
AS
BEGIN
    -- Desactiva el envío de mensajes adicionales, para optimizar el rendimiento
    SET NOCOUNT ON;

    -- Inserta un nuevo registro en la tabla de auditoría cada vez que ocurre una eliminación en la tabla 'clientes'.
    INSERT INTO auditoria (tabla, tipo_operacion, datos_anteriores, fecha_operacion, usuario)
    
    -- Realiza una selección de los datos eliminados desde la tabla virtual 'deleted', que almacena
    -- los valores de las filas antes de ser eliminadas.
    SELECT 
        'clientes' AS tabla, -- Especifica el nombre de la tabla afectada, en este caso, 'clientes'.
        'DELETE' AS tipo_operacion, -- Define el tipo de operación como 'DELETE', para indicar que fue una eliminación.
        
        -- Concadena los valores de cada columna en un solo campo de texto.
        -- Este campo, 'datos_anteriores', contendrá la información que tenía cada registro antes de ser eliminado.
        CONCAT(
            'dni_c:', CAST(d.dni_c AS NVARCHAR), ', ', -- Convierte el campo 'dni_c' a texto y lo concatena con el resto.
            'nombre_c:', d.nombre_c, ', ',              -- Concatena el campo 'nombre_c'.
            'apellido:', d.apellido, ', ',              -- Concatena el campo 'apellido'.
            'fechaNac_c:', CAST(d.fechaNac_c AS NVARCHAR), ', ', -- Concatena 'fechaNac_c' convirtiéndolo a texto.
            'email:', d.email, ', ',                    -- Concatena el campo 'email'.
            'direccion:', d.direccion, ', ',            -- Concatena el campo 'direccion'.
            'telefono:', CAST(d.telefono AS NVARCHAR), ', ', -- Concatena 'telefono' convirtiéndolo a texto.
            'eliminado:', d.eliminado                   -- Concatena el campo 'eliminado'.
        ) AS datos_anteriores, -- El resultado final se almacena en el campo 'datos_anteriores'.

        GETDATE() AS fecha_operacion, -- Registra la fecha y hora en que se realizó la operación.
        SYSTEM_USER AS usuario        -- Registra el usuario del sistema que realizó la operación.
    
    FROM deleted d; -- La información se obtiene de la tabla virtual 'deleted', que contiene los datos antes de la eliminación.

END;
GO -- Finaliza el script del trigger.


--2. Trigger para prevenir DELETE con mensaje personalizado
-- Este trigger tiene el objetivo de evitar la eliminación de registros en esta tabla, 
-- lanzando un mensaje de error y cancelando la transacción.
CREATE TRIGGER trg_prevent_delete
ON [dbo].[clientes] -- Especifica la tabla en la cual se evitará la operación de eliminación. En este caso, 'clientes'.
INSTEAD OF DELETE
AS
BEGIN
    -- Desactiva el envío de mensajes adicionales, para optimizar el rendimiento.
    SET NOCOUNT ON;

    -- Lanza un mensaje de error personalizado que indica que no se permite la eliminación de registros en la tabla.
    RAISERROR ('No está permitido eliminar registros de la tabla clientes.', 16, 1);

    -- Revierte la transacción para asegurarse de que la operación de eliminación no se complete.
    ROLLBACK TRANSACTION;
END;
GO -- Finaliza el script del trigger.


--3. Pruebas:
--3.1. Prueba del Trigger de Auditoría en UPDATE
UPDATE clientes
set nombre_c = 'Laurella Olmos', telefono = 1684621548
WHERE nombre_c = 'Laurella';-- Se actualizan datos de un cliente

--3.1.1. Verificacion de la tabla de auditoria para todos los Update
SELECT * from [dbo].[auditoria]
where tipo_operacion = 'UPDATE';

--3.2. Prueba del Trigger de Auditoría en DELETE
--3.2.1. Primero se desactiva el trigger de prevención de eliminación para realizar las pruebas
DISABLE TRIGGER trg_prevent_delete ON [dbo].[clientes]

--3.2.2. Se elimina un registro para verificar que los datos previos al borrado se registren en la tabla de auditoría
delete from clientes
where nombre_c = 'Laurella Olmos'

--3.2.3. Verificacion de la tabla de auditoria para todos los DELETE
SELECT * from [dbo].[auditoria]
where tipo_operacion = 'DELETE';

--3.3. Prueba del Trigger de prevencion de DELETE
--3.3.1. Luego de ejecutar la operación de prueba anterior volvemos a habilitar el trigger para restaurar su funcionalidad
ENABLE TRIGGER trg_prevent_delete ON [dbo].[clientes]

--3.3.2. Se intenta eliminar un registro
delete from clientes
where nombre_c = 'Laurella Olmos'
