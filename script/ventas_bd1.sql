SET IDENTITY_INSERT ventas ON;

INSERT INTO ventas (id_venta, id_usuario, id_cliente, fecha_venta, total_venta, numeroVenta, estado, id_TipoFact) VALUES
(1, 3, 21472621, '2024-10-01', 250.00, 10001, 'pagado', 1),
(2, 8, 30630802, '2024-10-02', 150.00, 10002, 'pendiente', 2),
(3, 13, 27312597, '2024-10-03', 300.00, 10003, 'entregado', 1),
(4, 8, 38892824, '2024-10-04', 180.00, 10004, 'pagado', 3),
(5, 3, 40328854, '2024-10-05', 500.00, 10005, 'pendiente', 2),
(6, 13, 31793521, '2024-10-06', 400.00, 10006, 'entregado', 1),
(7, 18, 32363768, '2024-10-07', 600.00, 10007, 'pagado', 3),
(8, 28, 30357497, '2024-10-08', 700.00, 10008, 'pendiente', 1),
(9, 33, 43627256, '2024-10-09', 220.00, 10009, 'entregado', 2),
(10, 38, 43064201, '2024-10-10', 350.00, 10010, 'pagado', 1);

set IDENTITY_INSERT ventas off;

SET IDENTITY_INSERT venta_detalle ON;

INSERT INTO venta_detalle (id_venta, id_detalle, id_producto, cantidad, sub_total, eliminado) VALUES
(1, 1, 9, 2, 200.00, 'no'),
(1, 2, 4, 1, 50.00, 'no'),
(2, 3, 3, 1, 150.00, 'no'),
(3, 4, 20, 3, 300.00, 'no'),
(4, 5, 34, 2, 180.00, 'no'),
(5, 6, 9, 5, 500.00, 'no'),
(6, 7, 20, 4, 400.00, 'no'),
(7, 8, 9, 6, 600.00, 'no'),
(8, 9, 20, 7, 700.00, 'no'),
(9, 10, 28, 2, 240.00, 'no'),
(10, 11, 31, 3, 600.00, 'no');

set IDENTITY_INSERT venta_detalle off;