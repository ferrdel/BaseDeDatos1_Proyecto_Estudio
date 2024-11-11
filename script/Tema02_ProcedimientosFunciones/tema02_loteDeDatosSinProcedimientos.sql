set IDENTITY_INSERT productos on;
--Inserción de Datos con Insert
INSERT INTO productos (id_producto, descripcion, id_categoria, precio_costo, precio_venta, stock, stock_min, eliminado, marca_prod, imagen)
VALUES
(51, 'Laptop ASUS VivoBook 15', 1, 500.00, 650.00, 15, 5, 'no', 4, NULL),
(52, 'Monitor ASUS 24" Full HD', 2, 150.00, 200.00, 30, 10, 'no', 4, NULL),
(53, 'Teclado ASUS Gaming', 3, 50.00, 75.00, 40, 15, 'no', 4, NULL),
(54, 'Ratón ASUS Gaming', 3, 30.00, 50.00, 35, 10, 'no', 4, NULL),
(55, 'Laptop ASUS ROG Strix', 1, 1000.00, 1300.00, 20, 5, 'no', 4, NULL),
(56, 'Auriculares ASUS ROG', 3, 70.00, 100.00, 50, 20, 'no', 4, NULL),
(57, 'SSD ASUS 500GB', 2, 80.00, 120.00, 25, 10, 'no', 4, NULL),
(58, 'Memoria RAM ASUS 16GB', 2, 60.00, 90.00, 40, 15, 'no', 4, NULL),
(59, 'Laptop ASUS ZenBook', 1, 750.00, 950.00, 18, 5, 'no', 4, NULL),
(60, 'Monitor ASUS 27" 4K', 2, 300.00, 450.00, 12, 5, 'no', 4, NULL),
(61, 'Mousepad ASUS RGB', 3, 20.00, 35.00, 50, 20, 'no', 4, NULL),
(62, 'Laptop ASUS TUF Gaming', 1, 800.00, 1050.00, 22, 7, 'no', 4, NULL),
(63, 'Mouse ASUS TUF', 3, 40.00, 60.00, 38, 12, 'no', 4, NULL),
(64, 'Teclado ASUS TUF', 3, 60.00, 85.00, 30, 12, 'no', 4, NULL),
(65, 'Adaptador ASUS WiFi', 2, 15.00, 25.00, 60, 25, 'no', 4, NULL),
(66, 'Laptop ASUS ExpertBook', 1, 950.00, 1250.00, 19, 6, 'no', 4, NULL),
(67, 'Cargador ASUS Laptop', 2, 30.00, 45.00, 40, 15, 'no', 4, NULL),
(68, 'Mochila ASUS Gaming', 3, 40.00, 60.00, 25, 10, 'no', 4, NULL),
(69, 'Pantalla ASUS 32" Curva', 2, 400.00, 550.00, 15, 5, 'no', 4, NULL),
(70, 'Cable HDMI ASUS', 2, 10.00, 20.00, 50, 20, 'no', 4, NULL),
(71, 'Laptop ASUS X515', 1, 400.00, 550.00, 25, 10, 'no', 4, NULL),
(72, 'Pantalla ASUS 24" Full HD', 2, 140.00, 180.00, 30, 12, 'no', 4, NULL),
(73, 'Teclado ASUS Wireless', 3, 45.00, 70.00, 50, 20, 'no', 4, NULL),
(74, 'Laptop ASUS Flip 14', 1, 650.00, 850.00, 20, 8, 'no', 4, NULL),
(75, 'Monitor ASUS 34" Curvo', 2, 500.00, 700.00, 12, 5, 'no', 4, NULL),
(76, 'Disco Duro ASUS 1TB', 2, 90.00, 130.00, 20, 8, 'no', 4, NULL),
(77, 'Mochila ASUS 15"', 3, 30.00, 45.00, 35, 12, 'no', 4, NULL),
(78, 'Auriculares ASUS 7.1', 3, 100.00, 130.00, 25, 10, 'no', 4, NULL),
(79, 'Laptop ASUS TUF Dash', 1, 950.00, 1200.00, 20, 7, 'no', 4, NULL),
(80, 'Teclado ASUS RGB', 3, 55.00, 80.00, 45, 15, 'no', 4, NULL),
(81, 'SSD ASUS 1TB', 2, 120.00, 170.00, 30, 12, 'no', 4, NULL),
(82, 'Laptop ASUS VivoBook Pro', 1, 700.00, 900.00, 17, 6, 'no', 4, NULL),
(83, 'Monitor ASUS 22"', 2, 120.00, 150.00, 22, 10, 'no', 4, NULL),
(84, 'Mouse ASUS Optical', 3, 15.00, 25.00, 45, 18, 'no', 4, NULL),
(85, 'Laptop ASUS X512', 1, 500.00, 650.00, 30, 10, 'no', 4, NULL),
(86, 'Disco Duro ASUS 500GB', 2, 50.00, 75.00, 40, 15, 'no', 4, NULL),
(87, 'Teclado ASUS Wireless RGB', 3, 55.00, 80.00, 50, 20, 'no', 4, NULL),
(88, 'Monitor ASUS 21" Full HD', 2, 130.00, 170.00, 35, 12, 'no', 4, NULL),
(89, 'Laptop ASUS ZenBook Flip', 1, 850.00, 1100.00, 16, 6, 'no', 4, NULL),
(90, 'Ratón ASUS TUF Gaming', 3, 35.00, 55.00, 40, 15, 'no', 4, NULL);

--Modificacion de Precios con instrucciones básicas SQL, un 25% de aumento
UPDATE productos
SET precio_venta = precio_venta * 1.25
WHERE marca_prod = (
    SELECT id_marca
    FROM marcas
    WHERE nombre_marca = 'ASUS'
);
--Productos afectados por la actualización
SELECT * 
FROM productos
WHERE marca_prod = (
    SELECT id_marca
    FROM marcas
    WHERE nombre_marca = 'ASUS'
);


