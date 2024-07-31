### **PreEntrega2-SQL**
**Segundo entregable curso CoderHouse comisión 57190
Profesor Anderson Ocaña**

# **Insercion de tablas**: 
Profes. Tuve un problema con la inserción de tablas mendiante archivos CSV, tuve errores con las id y también con algunos values, intente arreglarlo de muchas formas, editando, probando otras formas de importacion y no me sale, se los escribo por acá por el límite de caracteres de la entrega de proyecto de Coder, quería saber si me pueden ayudar con eso.
Les deje una carpeta con todos los CSV y SQL (los SQL no me dieron errores para agregarlos manualmente, no las dejé insertadas por el simple echo de que serían unas 4000 líneas de código) creados en Mackroo, para tener algunas tablas ingrese manualmente asi poder probar la funcionalidad del proyecto.

# **Descripción** :
Esta base de datos está diseñada para gestionar una tienda de ropa en línea. La base de datos almacenará información sobre los productos disponibles, los clientes que compran en la tienda, los pedidos realizados por los clientes, y los detalles de cada pedido.

# **Diagrama de entidad relación de la base de datos** (dejo un pdf con el diagrama hecho en dbdiagram.io)
```
+-------------------+       +-----------------+        +------------------------+
|      Product      |       |   ProductCategory |      |         Customer       |
+-------------------+       +-----------------+        +------------------------+
| product_id        |       | category_id     |        | customer_id            |
| name              |  +--->| name            |        | first_name             |
| description       |       +-----------------+        | last_name              |
| price             |                                  | email                  |
| stock             |                                  | phone                  |
| category_id  -----+                                  +------------------------+

+------------------------+      +------------------+      +------------------------+
|   CustomerAddress      |      |      Order       |      |     OrderDetail        |
+------------------------+      +------------------+      +------------------------+
| address_id             |      | order_id         |      | order_detail_id        |
| customer_id   ---------+--->  | customer_id      |      | order_id               |
| address                |      | order_date       |      | product_id             |
| city                   |      | status           |      | quantity               |
| state                  |      +------------------+      | price                  |
| postal_code            |                                +------------------------+
| country                |                               
                                                         
+------------------------+      +-------------------+     +------------------------+
|     PaymentMethod      |      |     Shipping      |     |      ProductReview      |
+------------------------+      +-------------------+     +------------------------+
| payment_id             |      | shipping_id       |     | review_id               |
| method                 |      | order_id          |     | product_id              |
+------------------------+      | shipping_date     |     | customer_id             |
                                | delivery_date     |     | rating                  |
                                | carrier           |     | review                  |
                                | tracking_number   |     | review_date             |
                                +-------------------+     +------------------------+

+------------------------+
|       Discount         |
+------------------------+
| discount_id            |
| code                   |
| description            |
| discount_percentage    |
| start_date             |
| end_date               |
+------------------------+

+------------------------+
|       Inventory         |
+------------------------+
| inventory_id            |
| product_id              |
| quantity                |
| last_update             |
+------------------------+
```
# Listado de las tablas que comprenden la base de datos
## Tabla: Categoría de Producto (ProductCategory)
- **Descripción:** Almacena información sobre las categorías de los productos.
- **Campos:**
  - `category_id` (ID de la categoría, tipo: INT, clave primaria)
  - `name` (Nombre de la categoría, tipo: VARCHAR(255))

## Tabla: Producto (Product)
- **Descripción:** Almacena información sobre los productos de la tienda.
- **Campos:**
  - `product_id` (ID del producto, tipo: INT, clave primaria)
  - `name` (Nombre del producto, tipo: VARCHAR(255))
  - `description` (Descripción del producto, tipo: TEXT)
  - `price` (Precio del producto, tipo: DECIMAL(10, 2))
  - `stock` (Stock del producto, tipo: INT)
  - `category_id` (ID de la categoría, tipo: INT, clave foránea)

## Tabla: Cliente (Customer)
- **Descripción:** Almacena información sobre los clientes de la tienda.
- **Campos:**
  - `customer_id` (ID del cliente, tipo: INT, clave primaria)
  - `first_name` (Nombre del cliente, tipo: VARCHAR(255))
  - `last_name` (Apellido del cliente, tipo: VARCHAR(255))
  - `email` (Email del cliente, tipo: VARCHAR(255))
  - `phone` (Teléfono del cliente, tipo: VARCHAR(20))

## Tabla: Dirección del Cliente (CustomerAddress)
- **Descripción:** Almacena las direcciones de los clientes.
- **Campos:**
  - `address_id` (ID de la dirección, tipo: INT, clave primaria)
  - `customer_id` (ID del cliente, tipo: INT, clave foránea)
  - `address` (Dirección, tipo: VARCHAR(255))
  - `city` (Ciudad, tipo: VARCHAR(100))
  - `state` (Estado, tipo: VARCHAR(100))
  - `postal_code` (Código postal, tipo: VARCHAR(20))
  - `country` (País, tipo: VARCHAR(100))

## Tabla: Pedido (Order)
- **Descripción:** Almacena información sobre los pedidos realizados por los clientes.
- **Campos:**
  - `order_id` (ID del pedido, tipo: INT, clave primaria)
  - `customer_id` (ID del cliente, tipo: INT, clave foránea)
  - `order_date` (Fecha del pedido, tipo: DATETIME)
  - `status` (Estado del pedido, tipo: VARCHAR(50))

## Tabla: Detalle del Pedido (OrderDetail)
- **Descripción:** Almacena información sobre los productos incluidos en los pedidos.
- **Campos:**
  - `order_detail_id` (ID del detalle del pedido, tipo: INT, clave primaria)
  - `order_id` (ID del pedido, tipo: INT, clave foránea)
  - `product_id` (ID del producto, tipo: INT, clave foránea)
  - `quantity` (Cantidad del producto, tipo: INT)
  - `price` (Precio del producto, tipo: DECIMAL(10, 2))

## Tabla: Método de Pago (PaymentMethod)
- **Descripción:** Almacena información sobre los métodos de pago.
- **Campos:**
  - `payment_id` (ID del método de pago, tipo: INT, clave primaria)
  - `method` (Método de pago, tipo: VARCHAR(255))

## Tabla: Envío (Shipping)
- **Descripción:** Almacena información sobre los envíos de los pedidos.
- **Campos:**
  - `shipping_id` (ID del envío, tipo: INT, clave primaria)
  - `order_id` (ID del pedido, tipo: INT, clave foránea)
  - `shipping_date` (Fecha de envío, tipo: DATETIME)
  - `delivery_date` (Fecha de entrega, tipo: DATETIME)
  - `carrier` (Transportista, tipo: VARCHAR(255))
  - `tracking_number` (Número de seguimiento, tipo: VARCHAR(255))

## Tabla: Descuentos y Promociones (Discount)
- **Descripción:** Almacena información sobre los descuentos y promociones.
- **Campos:**
  - `discount_id` (ID del descuento, tipo: INT, clave primaria)
  - `code` (Código de descuento, tipo: VARCHAR(50))
  - `description` (Descripción del descuento, tipo: VARCHAR(255))
  - `discount_percentage` (Porcentaje de descuento, tipo: DECIMAL(5, 2))
  - `start_date` (Fecha de inicio, tipo: DATETIME)
  - `end_date` (Fecha de finalización, tipo: DATETIME)

## Tabla: Reseñas de Productos (ProductReview)
- **Descripción:** Almacena las reseñas de los productos hechas por los clientes.
- **Campos:**
  - `review_id` (ID de la reseña, tipo: INT, clave primaria)
  - `product_id` (ID del producto, tipo: INT, clave foránea)
  - `customer_id` (ID del cliente, tipo: INT, clave foránea)
  - `rating` (Calificación, tipo: INT)
  - `review` (Reseña, tipo: TEXT)
  - `review_date` (Fecha de la reseña, tipo: DATETIME)

## Tabla: Inventario (Inventory)
- **Descripción:** Almacena información sobre el inventario de los productos.
- **Campos:**
  - `inventory_id` (ID del inventario, tipo: INT, clave primaria)
  - `product_id` (ID del producto, tipo: INT, clave foránea)
  - `quantity` (Cantidad en inventario, tipo: INT)
  - `last_update` (Fecha de la última actualización, tipo: DATETIME)
  - 
## Trigger: Acualizacion del stock
- **Descripción:** Actualizar el stock del producto después de insertar un detalle de orden
- **Tablas Interactuadas:** Product, OrderDetail

## Función: Calcular descuento
- **Descripción:** Calcular el precio con descuento de un producto.

## Views: 
- **Descripción:** ProductsWithCategory combina información de las tablas Product y ProductCategory para proporcionar una visión más completa de los productos junto con sus categorías.
- Campos relacionados: product_id, product_name, description, price, stock, category_name.
- **Descripción:** OrdersWithDetails combina información de las tablas Orders, Customer, y OrderDetail para proporcionar una visión detallada de las órdenes realizadas, incluyendo información del cliente y los detalles de los productos pedidos.
- Campos relacionados: order_id, order_date, status, first_name, last_name, product_id, quantity, price.
