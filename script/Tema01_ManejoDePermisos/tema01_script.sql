use proyecto_bd_I;

--------- (1) Permisos a nivel de usuarios ---------

-- creacion de UsuarioAdmin y UsuarioLectura atreves de LOGIN
CREATE LOGIN UsuarioAdmin WITH PASSWORD = '1234';
CREATE LOGIN UsuarioLectura WITH PASSWORD = '1234';

-- creacion de los usuarios en la base de datos
CREATE USER UsuarioAdmin FOR LOGIN UsuarioAdmin;
CREATE USER UsuarioLectura FOR LOGIN UsuarioLectura;

-- asignacion de permisos de administrador 
ALTER ROLE db_owner ADD MEMBER UsuarioAdmin;

-- asignacion de permisos de lectura
ALTER ROLE db_datareader ADD MEMBER UsuarioLectura;

-- se le da permiso a UsuarioLectura para ejecutar el procedimiento 'spInsertarProducto'
GRANT EXECUTE ON OBJECT::dbo.spInsertarProducto TO UsuarioLectura;

-- insertar producto ingresando como UsuarioAdmin
USE proyecto_bd_I;
INSERT INTO productos (descripcion, id_categoria, precio_costo, precio_venta, stock, stock_min, eliminado, marca_prod, imagen)
VALUES ('Producto Directo Admin', 1, 100.0, 150.0, 200, 20, 'No', 1, NULL);

-- insertar producto ingresando como UsuarioAdmin
USE proyecto_bd_I;
INSERT INTO productos (descripcion, id_categoria, precio_costo, precio_venta, stock, stock_min, eliminado, marca_prod, imagen)
VALUES ('Producto Directo Lectura', 1, 80.0, 120.0, 50, 5, 'No', 1, NULL);

-- insercion de producto con UsuarioLectura mendiante el procedimiento
USE proyecto_bd_I;
EXEC spInsertarProducto 
    @descripcion = 'Producto Procedimiento Lectura', 
    @id_categoria = 1, 
    @precio_costo = 60.0, 
    @precio_venta = 90.0, 
    @stock = 30, 
    @stock_min = 5, 
    @eliminado = 'No', 
    @marca_prod = 1, 
    @imagen = NULL;

--------- (2) Permisos a nivel de usuarios ---------

-- creacion de usuarios
CREATE LOGIN UsuarioLecturaRol WITH PASSWORD = '1234';
CREATE LOGIN UsuarioSinRol WITH PASSWORD = '1234';

-- creacion de los usuarios dentro de la base de datos
USE proyecto_bd_I;
CREATE USER UsuarioLecturaRol FOR LOGIN UsuarioLecturaRol;
CREATE USER UsuarioSinRol FOR LOGIN UsuarioSinRol;

-- creacion del rol
CREATE ROLE RolSoloLecturaProductos;

-- otorgamos permisos de lectura sobre la tabla 'productos' al rol
GRANT SELECT ON dbo.productos TO RolSoloLecturaProductos;

-- asigna el rol de solo lectura al usuario UsuarioLecturaRol
ALTER ROLE RolSoloLecturaProductos ADD MEMBER UsuarioLecturaRol;

-- ejecutar como UsuarioLecturaRol y como UsuarioSinRol
USE proyecto_bd_I;
SELECT * FROM dbo.productos;
SELECT * FROM dbo.clientes;

