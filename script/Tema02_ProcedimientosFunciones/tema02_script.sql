
--1. Procedimiento para Insertar elementos
CREATE PROCEDURE spInsertarProducto
    @descripcion VARCHAR(50),
    @id_categoria INT,
    @precio_costo FLOAT,
    @precio_venta FLOAT,
    @stock INT,
    @stock_min INT,
    @eliminado VARCHAR(30),
    @marca_prod INT = NULL,  -- Se permite NULL para marca_prod
    @imagen VARCHAR(MAX) = NULL
AS
BEGIN
    INSERT INTO productos (descripcion, id_categoria, precio_costo, precio_venta, stock, stock_min, eliminado, marca_prod, imagen)
    VALUES (@descripcion, @id_categoria, @precio_costo, @precio_venta, @stock, @stock_min, @eliminado, @marca_prod, @imagen);

    PRINT 'Producto insertado exitosamente';
END;

EXEC spInsertarProducto 'Producto Procedimiento', 1, 50.00, 70.00, 100, 10, 'No', 1, NULL;

--2. Procedimiento para Delete elemento por nombre
CREATE PROCEDURE spEliminarProducto
    @descripcion VARCHAR(50)
AS
BEGIN
    DELETE FROM productos
    WHERE descripcion = @descripcion;

    PRINT 'Producto eliminado exitosamente';
END;

EXEC spEliminarProducto 'Producto Procedimiento'; --eliminando el producto que creamos

--3. Procedimiento para modificar todos los precios de productos una misma marca
CREATE PROCEDURE spActualizarPrecioVentaMarca(
    @NombreMarca VARCHAR(30),
    @PrecioNuevo DECIMAL(6,2)
)
AS
BEGIN
    -- Actualizar el precio de venta de los productos de la marca especificada
    UPDATE p
    SET p.precio_venta =  p.precio_venta * @PrecioNuevo
    FROM productos p
    INNER JOIN marcas m ON p.marca_prod = m.id_marca
    WHERE m.nombre_marca = @NombreMarca

    PRINT 'Precios actualizados correctamente.'
END;

EXECUTE spActualizarPrecioVentaMarca 'Intel', 1.20 --aumenta el precio en un 20% 

--4. Función para traer los registros de una misma marca
CREATE FUNCTION fnTotalMarca(
    @NombreMarca VARCHAR(30)
)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM productos p
    WHERE p.marca_prod IN (
        SELECT m.id_marca
        FROM marcas m
        WHERE nombre_marca = @NombreMarca
    )
);

SELECT * FROM fnTotalMarca('Intel');

--5. Funcion que trae todos los de un mismo perfil
CREATE FUNCTION fnUsuariosPorPerfil (
    @DescripcionPerfil VARCHAR(20)
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        u.id_usuario,
        u.apellido,
        u.nombre,
        u.usuario,
        u.email,
        u.estado_perfil
    FROM users u
    JOIN perfiles p ON u.id_perfil = p.id_perfil
    WHERE p.descripcion = @DescripcionPerfil
);

SELECT * FROM fnUsuariosPorPerfil('Vendedor');

--6. Pasar fecha de nacimiento del usuario a formato texto
CREATE FUNCTION fnFechaNacimientoUsuarioTexto (
    @dni_usuario BIGINT
)
RETURNS VARCHAR(50)
AS
BEGIN
    DECLARE @FechaNacimiento DATE;
    DECLARE @FechaTexto VARCHAR(50);

    -- Obtener la fecha de nacimiento del cliente según su DNI
    SELECT @FechaNacimiento = fecha_nac
    FROM users
    WHERE dni_usuario = @dni_usuario;

    -- Si la fecha de nacimiento es NULL, retornar un mensaje vacío o personalizado
    IF @FechaNacimiento IS NULL
        RETURN 'Fecha no disponible';

    -- Construir la fecha en formato de texto
    SET @FechaTexto = CONCAT(
        DAY(@FechaNacimiento), ' de ',
        DATENAME(MONTH, @FechaNacimiento), ' de ',
        YEAR(@FechaNacimiento)
    );

    RETURN @FechaTexto;
END;

SELECT dbo.fnFechaNacimientoUsuarioTexto(12345678) AS FechaNacimientoTexto;

