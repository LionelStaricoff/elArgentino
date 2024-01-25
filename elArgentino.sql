
DROP DATABASE if EXISTS elargentino;
CREATE DATABASE if NOT EXISTS elargentino DEFAULT CHARACTER SET UTF8 collate UTF8_SPANISH_CI;
USE elargentino;


--tabla usuarios
CREATE TABLE IF NOT EXISTS users (
id_user INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
name VARCHAR(50) NOT NULL,
password VARCHAR(50) NOT NULL,
WhatsApp  VARCHAR(50),
id_rol INT UNSIGNED,
FOREIGN KEY (id_rol) REFERENCES roles (id_rol)
);



-- tabla roles
CREATE TABLE IF NOT EXISTS roles (
id_rol INT UNSIGNED KEY AUTO_INCREMENT NOT NULL,
name VARCHAR(50) NOT NULL
);





-- tabla ventas
CREATE TABLE IF NOT EXISTS ventas (
id_venta INT UNSIGNED KEY AUTO_INCREMENT NOT NULL,
fecha DATE NOT NULL,
descuento INT 
);

-- tabla productos
CREATE TABLE IF NOT EXISTS productos(
id_producto INT UNSIGNED KEY AUTO_INCREMENT NOT NULL,
NAME VARCHAR(50) UNIQUE NOT NULL,
precio_venta INT UNSIGNED NOT NULL,
descripcion VARCHAR(100),
stock INT UNSIGNED,
stock_minimo int unsigned,
se_pide boolean,
codigo_barra varchar(250),
id_precio_costo INT UNSIGNED,
FOREIGN KEY (id_producto) REFERENCES proveedor (id_proveedor)
);




-- tabla proveedor
CREATE TABLE IF NOT EXISTS proveedor(
id_proveedor INT UNSIGNED KEY AUTO_INCREMENT NOT NULL,
NAME VARCHAR(50) NOT NULL,
precio_costo INT UNSIGNED NOT NULL, 
id_producto INT UNSIGNED 
);



-- tabla compras
CREATE TABLE IF NOT EXISTS compras(
id_compras INT UNSIGNED KEY AUTO_INCREMENT NOT NULL,
fecha DATE
);

-- creando muchas compras a muchos productos
CREATE TABLE IF NOT EXISTS compras_productos(
id_compras INT UNSIGNED NOT NULL,
id_producto INT UNSIGNED NOT NULL,
cantidad INT UNSIGNED NOT NULL,
FOREIGN KEY (id_compras) REFERENCES compras (id_compras),
FOREIGN KEY (id_producto) REFERENCES productos (id_producto) 
);



-- creando tabla ventas
CREATE TABLE IF NOT EXISTs ventas(
id_ventas INT UNSIGNED KEY AUTO_INCREMENT NOT NULL,
fecha DATE NOT null,
descuento int
);

-- creando tabla ventas
CREATE TABLE IF NOT EXISTS ventas_productos(
id_ventas INT UNSIGNED NOT NULL,
id_producto INT UNSIGNED NOT NULL,
cantidad INT UNSIGNED NOT NULL,
FOREIGN KEY (id_ventas) REFERENCES ventas (id_ventas),
FOREIGN KEY (id_producto) REFERENCES productos (id_producto) 
);

















































	












-- isertando usuarios
INSERT INTO roles(NAME) VALUES ("admin"),("guess");

-- insertando personas 
INSERT INTO users (NAME, PASSWORD, WhatsApp,id_rol) VALUES ("lionel","1234","1164244054",1);



-- creando productos nuevos
SET @proveedor_name="tauros";
SET @producto_name="lapicero negro";
SELECT @producto_name;
INSERT INTO proveedor (NAME, precio_costo) VALUES (@proveedor_name, 500);
INSERT INTO productos (NAME, precio_venta, descripcion, stock) VALUES (@producto_name, 1000, "lapiz comun", 20); 

-- actualizando proveedor
UPDATE proveedor SET id_producto=(SELECT id_producto FROM productos WHERE productos.NAME=@producto_name);

-- actualizando producto
SET @cabiando_precio=1;
SELECT @cabiando_precio;

UPDATE productos
INNER JOIN proveedor ON productos.id_precio_costo = proveedor.id_proveedor
SET productos.id_precio_costo=@cabiando_precio
WHERE proveedor.id_producto = productos.id_producto;

SELECT * from productos;




-- trayendo el producto
SET @producto_name="lapicero negro";
SELECT @producto_name;
SELECT productos.NAME, productos.precio_venta, productos.descripcion, productos.stock, proveedor.NAME, proveedor.precio_costo FROM productos
LEFT join proveedor ON productos.id_precio_costo=proveedor.id_proveedor
 WHERE productos.NAME=@producto_name;

SELECT @producto_name;

 
 
-- insertando productos y proveedores
SET @producto_id=1;
SELECT @producto_id;
INSERT INTO proveedor (NAME, precio_costo, id_producto) VALUES (@pname, 500, (SELECT id_productos FROM productos WHERE productos.name = @pname) );  
INSERT INTO productos (NAME, precio_venta, descripcion, stock, id_precio_costo) VALUES ("lapicero negro", 1000, "lapiz comun", 20, (SELECT proveedor.id_proveedor FROM proveedores WHERE proveedor.id_producto = productos.id_producto); 



-- insertando compras
INSERT INTO compras (fecha) VALUES (CURDATE() );
INSERT INTO compras_productos (id_compras, id_producto, cantidad) VALUES (1,1,5);

-- trayecndo compras
SELECT c.fecha, cp.cantidad, p.NAME,p.precio_venta
FROM compras AS c
INNER JOIN compras_productos AS cp
    ON c.id_compras = cp.id_compras
INNER JOIN productos AS p
    ON cp.id_producto = p.id_producto
WHERE c.fecha = CURDATE();



-- insertando ventas
INSERT INTO ventas (fecha, descuento) VALUES (CURDATE(), -100);
INSERT INTO ventas_productos (id_ventas, id_producto, cantidad) VALUES (1,1,5);

-- trayendo ventas
SELECT v.fecha, vp.cantidad, p.NAME, p.precio_venta, v.descuento ,SUM(p.precio_venta * vp.cantidad +v.descuento) AS total
FROM ventas AS v
INNER JOIN ventas_productos AS vp
ON v.id_ventas = vp.id_ventas
INNER JOIN productos AS p
ON vp.id_producto = p.id_producto
WHERE v.fecha = CURDATE();





--trayendo usuarios
SELECT users.name,users.password,users.WhatsApp , roles.name FROM users LEFT join roles ON users.id_rol = roles.id_rol;
-- pruevas
SELECT * FROM users;
SELECT * FROM roles;
SELECT * FROM productos;
SELECT * FROM proveedor;
SELECT * FROM compras;
SELECT * FROM compras_productos;
DESC productos;
DESC precio_costo;





