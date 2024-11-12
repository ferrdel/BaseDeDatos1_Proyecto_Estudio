
use proyecto_bd_I;

--script para la insercion de datos

-- tabla ventas
DECLARE @i INT = 11;

WHILE @i <= 1000000
BEGIN
    INSERT INTO ventas (id_usuario, id_cliente, fecha_venta, total_venta, numeroVenta, estado, id_TipoFact)
    VALUES (
        (1 + @i % 50),                -- id_usuario, suponiendo que tienes 1000 usuarios en la tabla 'users'
        (SELECT TOP 1 dni_c FROM clientes ORDER BY NEWID()), -- id_cliente, suponiendo que tienes 500 clientes en la tabla 'clientes'
        DATEADD(DAY, @i % 365, '2024-01-01'), -- fecha_venta con una fecha variada
        RAND() * 50000 + 500,              -- total_venta, un valor aleatorio entre 50 y 550
        @i,                             -- numeroVenta, un número de venta único para cada registro
        'Activo',                       -- estado, puedes cambiarlo según tu necesidad
        (1 + @i % 10)                    -- id_TipoFact, suponiendo que tienes 5 tipos de factura en 'tipo_factura'
    );

    SET @i = @i + 1;
END;


-- tabla ventas_detalle

DECLARE @j INT = 1;

WHILE @j <= 1000000
BEGIN
    DECLARE @id_venta INT = (SELECT TOP 1 id_venta FROM ventas ORDER BY NEWID());
    DECLARE @id_producto INT = (SELECT TOP 1 id_producto FROM productos ORDER BY NEWID());
    DECLARE @cantidad INT = ABS(CHECKSUM(NEWID()) % 10) + 1;
    DECLARE @precio DECIMAL(10, 2) = (SELECT precio_venta FROM productos WHERE id_producto = @id_producto);
    DECLARE @sub_total DECIMAL(10, 2) = @cantidad * @precio;

    INSERT INTO venta_detalle (id_venta, id_producto, cantidad, sub_total, eliminado)
    VALUES (
        @id_venta,
        @id_producto,
        @cantidad,
        @sub_total,
        'no' -- Assuming 0 for not deleted
    );

    SET @j = @j + 1;
END;

-- Consulta Realizada
-- Obtener las ventas en un periodo de fecha, a que usuario pertenece, total venta,producto y cantidad del mismo

SET STATISTICS TIME ON
SET STATISTICS IO ON
GO
SELECT 
    v.id_venta,
	v.numeroVenta,
    v.fecha_venta,
    u.nombre AS usuario_nombre,
    u.apellido AS usuario_apellido,
	u.telefono,
    v.total_venta,
    p.descripcion AS producto_descripcion,
	p.precio_venta,
    vd.cantidad
FROM 
    ventas v
INNER JOIN 
    users u ON v.id_usuario = u.id_usuario
INNER JOIN 
    venta_detalle vd ON v.id_venta = vd.id_venta
INNER JOIN 
    productos p ON vd.id_producto = p.id_producto
WHERE 
    v.fecha_venta BETWEEN '2023-10-01' AND '2024-11-08'
ORDER BY 
    v.fecha_venta;


--Definir un índice agrupado sobre la columna fecha y repetir la consulta anterior. 
--Registrar el plan de ejecución utilizado por el motor y los tiempos de respuesta.

CREATE NONCLUSTERED INDEX IDX_Ventas_FechaVenta ON ventas (fecha_venta);

DROP INDEX [IDX_Ventas_FechaVenta] ON [ventas] 
GO


--Definir otro índice agrupado sobre la columna fecha pero que además incluya las columnas seleccionadas
--y repetir la consulta anterior. Registrar el plan de ejecución utilizado por el motor y los tiempos de respuesta.

CREATE NONCLUSTERED INDEX IDX_Ventas_FechaVenta_Incluido
ON ventas (fecha_venta)
INCLUDE (numeroVenta, id_cliente, total_venta);

DROP INDEX [IDX_Ventas_FechaVenta_Incluido] ON [ventas] 
GO


-- Obtener las ventas en un periodo de fecha, a que usuario pertenece, total venta,producto y cantidad del mismo

SET STATISTICS TIME ON
SET STATISTICS IO ON
GO
SELECT 
    v.id_venta,
	v.numeroVenta,
    v.fecha_venta,
    u.nombre AS usuario_nombre,
    u.apellido AS usuario_apellido,
	u.telefono,
    v.total_venta,
    p.descripcion AS producto_descripcion,
	p.precio_venta,
    vd.cantidad
FROM 
    ventas v
INNER JOIN 
    users u ON v.id_usuario = u.id_usuario
INNER JOIN 
    venta_detalle vd ON v.id_venta = vd.id_venta
INNER JOIN 
    productos p ON vd.id_producto = p.id_producto
WHERE 
    v.fecha_venta BETWEEN '2023-10-01' AND '2024-11-08'
ORDER BY 
    v.fecha_venta;






	




--Unique Index
CREATE UNIQUE INDEX idx_productos_productcode ON productos (id_producto);



--Filtered Index
CREATE INDEX idx_ventas_recientes ON ventas (fecha_venta) WHERE fecha_venta >= '2022-01-01';



--Full-Text Index
CREATE FULLTEXT INDEX ON productos (descripcion) KEY INDEX idx_productos_id_producto;