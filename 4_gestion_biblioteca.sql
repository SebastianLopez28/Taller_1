-- =========================================================
-- 4. GESTION BIBLIOTECA - Normalizado a 3FN
-- Resuelve: clientes duplicados y precios inconsistentes
-- =========================================================
CREATE DATABASE IF NOT EXISTS gestion_biblioteca;
USE gestion_biblioteca;

CREATE TABLE CLIENTES (
    ID_CLIENTE     INT PRIMARY KEY AUTO_INCREMENT,
    CUSTOMER_NAME  VARCHAR(100) NOT NULL,
    EMAIL          VARCHAR(100) NOT NULL UNIQUE,
    ADDRESS        VARCHAR(150) NOT NULL
);

CREATE TABLE LIBROS (
    ID_LIBRO  INT PRIMARY KEY AUTO_INCREMENT,
    TITLE     VARCHAR(150) NOT NULL,
    AUTHOR    VARCHAR(100) NOT NULL,
    PRICE     DECIMAL(10,2) NOT NULL   -- precio de catálogo (estandarizado)
);

CREATE TABLE PEDIDOS (
    ID_PEDIDO   INT PRIMARY KEY,
    ID_CLIENTE  INT NOT NULL,
    ORDER_DATE  DATE NOT NULL,
    FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTES(ID_CLIENTE)
);

CREATE TABLE DETALLE_PEDIDO (
    ID_PEDIDO       INT NOT NULL,
    ID_LIBRO        INT NOT NULL,
    QUANTITY        INT NOT NULL,
    PRICE_AT_ORDER  DECIMAL(10,2) NOT NULL, -- precio real cobrado (histórico)
    PRIMARY KEY (ID_PEDIDO, ID_LIBRO),
    FOREIGN KEY (ID_PEDIDO) REFERENCES PEDIDOS(ID_PEDIDO),
    FOREIGN KEY (ID_LIBRO) REFERENCES LIBROS(ID_LIBRO)
);

-- Clientes deduplicados (John Smith aparecía repetido 3 veces)
INSERT INTO CLIENTES (CUSTOMER_NAME, EMAIL, ADDRESS) VALUES
('John Smith','john@email.com','123 Main St, Boston, MA 02101'),
('Jane Doe','jane@email.com','456 Oak Avenue, Portland, OR 97201'),
('Sarah Johnson','sarah.j@company.com','789 Pine Street, Seattle, WA 98101');

-- Catálogo de libros con precio estándar
INSERT INTO LIBROS (TITLE, AUTHOR, PRICE) VALUES
('Database Design Principles','C.J. Date',45.99),
('SQL Cookbook','Anthony Molinaro',39.99),
('Advanced SQL Techniques','Joe Celko',52.99);

INSERT INTO PEDIDOS VALUES
(1,1,'2024-01-15'),
(2,1,'2024-01-20'),
(3,2,'2024-01-18'),
(4,1,'2024-02-01'),
(5,3,'2024-02-03');

-- El precio inconsistente se conserva como "precio real de esa venta"
INSERT INTO DETALLE_PEDIDO VALUES
(1,1,2,45.99),
(1,2,1,39.99),
(2,1,1,46.99),
(3,2,1,35.99),
(4,3,1,52.99),
(5,1,3,45.99);
