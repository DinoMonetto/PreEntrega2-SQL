-- Dropeo por las dudas que exista una base con el mismo nombre
DROP DATABASE IF EXISTS TiendaRopa;

-- Crear base de datos
CREATE DATABASE TiendaRopa;

-- Usar base de datos
USE TiendaRopa;

-- Tabla: Categoría de Producto
CREATE TABLE ProductCategory (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);
-- Tabla: Producto
CREATE TABLE Product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES ProductCategory(category_id)
);

-- Tabla: Cliente
CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(20)
);

-- Tabla: Dirección del Cliente
CREATE TABLE CustomerAddress (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    country VARCHAR(100) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- Tabla: Pedido
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME NOT NULL,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- Tabla: Detalle del Pedido
CREATE TABLE OrderDetail (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

-- Tabla: Método de Pago
CREATE TABLE PaymentMethod (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    method VARCHAR(255) NOT NULL
);

-- Tabla: Envío
CREATE TABLE Shipping (
    shipping_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    shipping_date DATETIME NOT NULL,
    delivery_date DATETIME NOT NULL,
    carrier VARCHAR(255) NOT NULL,
    tracking_number VARCHAR(255) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Tabla: Descuentos y Promociones
CREATE TABLE Discount (
    discount_id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(50) NOT NULL,
    description VARCHAR(255),
    discount_percentage DECIMAL(5, 2) NOT NULL,
    start_date DATETIME NOT NULL,
    end_date DATETIME NOT NULL
);

-- Tabla: Reseñas de Productos
CREATE TABLE ProductReview (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    customer_id INT,
    rating INT NOT NULL,
    review TEXT,
    review_date DATETIME NOT NULL,
    FOREIGN KEY (product_id) REFERENCES Product(product_id),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- Tabla: Inventario
CREATE TABLE Inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    quantity INT NOT NULL,
    last_update DATETIME NOT NULL,
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

-- Script de Inserción de Datos

-- Insertar datos en ProductCategory
INSERT INTO ProductCategory (name) VALUES ('Camisetas'), ('Pantalones'), ('Zapatos');

-- Insertar datos en Product
INSERT INTO Product (name, description, price, stock, category_id) VALUES 
('Camiseta Blanca', 'Camiseta blanca de algodón', 19.99, 100, 1),
('Pantalón Vaquero', 'Pantalón vaquero azul', 49.99, 50, 2),
('Zapatos Deportivos', 'Zapatos deportivos de color negro', 59.99, 30, 3);

-- Insertar datos en Customer
INSERT INTO Customer (first_name, last_name, email, phone) VALUES 
('Juan', 'Pérez', 'juan.perez@gmail.com', '123456789'),
('Ana', 'García', 'ana.garcia@gmail.com', '987654321');

-- Insertar datos en CustomerAddress
INSERT INTO CustomerAddress (customer_id, address, city, postal_code, country) VALUES 
(1, 'Calle Falsa 123', 'Ciudad', '12345', 'País'),
(2, 'Avenida Siempre Viva 456', 'Ciudad', '67890', 'País');

-- Insertar datos en Orders
INSERT INTO Orders (customer_id, order_date, status) VALUES 
(1, '2023-07-30 10:00:00', 'Enviado'),
(2, '2023-07-30 11:00:00', 'Procesando');

-- Insertar datos en OrderDetail
INSERT INTO OrderDetail (order_id, product_id, quantity, price) VALUES 
(1, 1, 2, 19.99),
(1, 2, 1, 49.99),
(2, 3, 1, 59.99);

-- Insertar datos en PaymentMethod
INSERT INTO PaymentMethod (method) VALUES ('Tarjeta de Crédito'), ('PayPal');

-- Insertar datos en Shipping
INSERT INTO Shipping (order_id, shipping_date, delivery_date, carrier, tracking_number) VALUES 
(1, '2023-07-31 10:00:00', '2023-08-02 10:00:00', 'DHL', 'TRACK123'),
(2, '2023-07-31 11:00:00', '2023-08-02 11:00:00', 'FedEx', 'TRACK456');

-- Insertar datos en Discount
INSERT INTO Discount (code, description, discount_percentage, start_date, end_date) VALUES 
('DESC10', '10% de descuento', 10, '2023-07-01 00:00:00', '2023-07-31 23:59:59');

-- Insertar datos en ProductReview
INSERT INTO ProductReview (product_id, customer_id, rating, review, review_date) VALUES 
(1, 1, 5, 'Muy buena camiseta', '2023-07-30 12:00:00');

-- Insertar datos en Inventory
INSERT INTO Inventory (product_id, quantity, last_update) VALUES 
(1, 100, '2023-07-30 10:00:00'),
(2, 50, '2023-07-30 10:00:00'),
(3, 30, '2023-07-30 10:00:00');

-- Script de Creación de Vistas

CREATE VIEW ProductsWithCategory AS
SELECT p.product_id, p.name AS product_name, p.description, p.price, p.stock, c.name AS category_name
FROM Product p
JOIN ProductCategory c ON p.category_id = c.category_id;

CREATE VIEW OrdersWithDetails AS
SELECT o.order_id, o.order_date, o.status, c.first_name, c.last_name, od.product_id, od.quantity, od.price
FROM Orders o
JOIN Customer c ON o.customer_id = c.customer_id
JOIN OrderDetail od ON o.order_id = od.order_id;

-- Script de Creación de Funciones

DELIMITER //

CREATE FUNCTION CalcularPrecioDescuento(
    precio_original DECIMAL(10,2),
    porcentaje_descuento DECIMAL(5,2)
) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE precio_descuento DECIMAL(10,2);
    SET precio_descuento = precio_original - (precio_original * porcentaje_descuento / 100);
    RETURN precio_descuento;
END //

DELIMITER ;


-- Script de Creación de Stored Procedures

DELIMITER //

CREATE PROCEDURE UpdateOrderStatus(
    IN p_order_id INT,
    IN p_new_status VARCHAR(50)
)
BEGIN
    UPDATE Orders
    SET status = p_new_status
    WHERE order_id = p_order_id;
END //

DELIMITER ;

-- Script de Creación de Triggers

DELIMITER //

CREATE TRIGGER UpdateStockAfterOrder
AFTER INSERT ON OrderDetail
FOR EACH ROW
BEGIN
    UPDATE Product
    SET stock = stock - NEW.quantity
    WHERE product_id = NEW.product_id;
END //

DELIMITER ;




