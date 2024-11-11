create database proyecto_bd_I;
go
use proyecto_bd_I;
go

--1. creacion de la tabla de categorias
CREATE TABLE [dbo].[categorias](
	[id_categoria] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](30) NOT NULL,
	[estado] [varchar](30) NOT NULL)

--2. Creacion de la tabla de clientes
CREATE TABLE [dbo].[clientes](
	[dni_c] [bigint] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[nombre_c] [varchar](50) NOT NULL,
	[apellido] [varchar](50) NOT NULL,
	[fechaNac_c] [date] NOT NULL,
	[email] [varchar](50) NOT NULL,
	[direccion] [varchar](50) NOT NULL,
	[telefono] [bigint] NOT NULL,
	[eliminado] [varchar](30) NOT NULL)

--3. Creacion de la tabla de marcas
CREATE TABLE [dbo].[marcas](
	[id_marca] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[nombre_marca] [varchar](30) NOT NULL,
	[estado_marca] [varchar](30) NOT NULL)

--4. Creacion de la tabla de tipos de perfiles
CREATE TABLE [dbo].[perfiles](
	[id_perfil] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](20) NULL,
	[estado] [bit] NULL)

--5. Creacion de la tabla de productos
CREATE TABLE [dbo].[productos](
	[id_producto] [bigint] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
	[id_categoria] [int] NOT NULL,
	[precio_costo] [float] NOT NULL,
	[precio_venta] [float] NOT NULL,
	[stock] [int] NOT NULL,
	[stock_min] [int] NOT NULL,
	[eliminado] [varchar](30) NOT NULL,
	[marca_prod] [int] NULL,
	[imagen] [varchar](max) NULL)

--6. Creacion de la tabla de tipo de facturas
CREATE TABLE [dbo].[tipo_factura](
	[cod_fact] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](max) NOT NULL)

--7. Creacion de la tabla de usuarios
CREATE TABLE [dbo].[users](
	[id_usuario] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[apellido] [varchar](50) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[dni_usuario] [int] NOT NULL,
	[telefono] [decimal](12, 0) NULL,
	[usuario] [varchar](50) NOT NULL,
	[contrasenia] [varchar](50) NOT NULL,
	[id_perfil] [int] NOT NULL,
	[email] [varchar](max) NOT NULL,
	[estado_perfil] [varchar](50) NOT NULL,
	[fecha_nac] [date] NULL)

--8. Creacion de la tabla de detalles para cada venta
CREATE TABLE [dbo].[venta_detalle](
	[id_detalle] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[id_venta] [int] NOT NULL,
	[id_producto] [bigint] NOT NULL,
	[cantidad] [int] NOT NULL,
	[sub_total] [float] NOT NULL,
	[eliminado] [varchar](20) NOT NULL)

--9. Creacion de la tabla de ventas
CREATE TABLE [dbo].[ventas](
	[id_venta] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[id_usuario] [int] NOT NULL,
	[id_cliente] [bigint] NOT NULL,
	[fecha_venta] [datetime] NOT NULL,
	[total_venta] [real] NULL,
	[numeroVenta] [decimal](18, 0) NOT NULL,
	[estado] [varchar](20) NULL,
	[id_TipoFact] [int] NOT NULL)


ALTER TABLE [dbo].[productos]  WITH CHECK ADD  CONSTRAINT [FK_productos_categorias] FOREIGN KEY([id_categoria])
REFERENCES [dbo].[categorias] ([id_categoria])
GO

ALTER TABLE [dbo].[productos] CHECK CONSTRAINT [FK_productos_categorias]
GO

ALTER TABLE [dbo].[productos]  WITH CHECK ADD  CONSTRAINT [FK_productos_marcas] FOREIGN KEY([marca_prod])
REFERENCES [dbo].[marcas] ([id_marca])
GO

ALTER TABLE [dbo].[productos] CHECK CONSTRAINT [FK_productos_marcas]
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD  CONSTRAINT [FK_users_perfiles] FOREIGN KEY([id_perfil])
REFERENCES [dbo].[perfiles] ([id_perfil])
GO

ALTER TABLE [dbo].[users] CHECK CONSTRAINT [FK_users_perfiles]
GO

ALTER TABLE [dbo].[venta_detalle]  WITH CHECK ADD  CONSTRAINT [fk_venta_detalle_productos] FOREIGN KEY([id_producto])
REFERENCES [dbo].[productos] ([id_producto])
GO
ALTER TABLE [dbo].[venta_detalle] CHECK CONSTRAINT [fk_venta_detalle_productos]
GO
ALTER TABLE [dbo].[venta_detalle]  WITH CHECK ADD  CONSTRAINT [FK_venta_detalle_VENTAS] FOREIGN KEY([id_venta])
REFERENCES [dbo].[ventas] ([id_venta])
GO

ALTER TABLE [dbo].[venta_detalle] CHECK CONSTRAINT [FK_venta_detalle_VENTAS]
GO

ALTER TABLE [dbo].[ventas]  WITH CHECK ADD  CONSTRAINT [FK_VENTAS_clientes] FOREIGN KEY([id_cliente])
REFERENCES [dbo].[clientes] ([dni_c])
GO

ALTER TABLE [dbo].[ventas] CHECK CONSTRAINT [FK_VENTAS_clientes]
GO
ALTER TABLE [dbo].[ventas]  WITH CHECK ADD  CONSTRAINT [FK_VENTAS_tipo_factura] FOREIGN KEY([id_TipoFact])
REFERENCES [dbo].[tipo_factura] ([cod_fact])
GO

ALTER TABLE [dbo].[ventas] CHECK CONSTRAINT [FK_VENTAS_tipo_factura]
GO
ALTER TABLE [dbo].[ventas]  WITH CHECK ADD  CONSTRAINT [FK_VENTAS_users] FOREIGN KEY([id_usuario])
REFERENCES [dbo].[users] ([id_usuario])
GO

ALTER TABLE [dbo].[ventas] CHECK CONSTRAINT [FK_VENTAS_users]
GO

