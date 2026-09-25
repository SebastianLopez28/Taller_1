-- =========================================================
-- 2. GESTION DE PELICULAS ALQUILADAS - Normalizado a 3FN
-- =========================================================
CREATE DATABASE IF NOT EXISTS gestion_peliculas;
USE gestion_peliculas;

CREATE TABLE CLIENTES (
    ID_CLIENTE        INT PRIMARY KEY AUTO_INCREMENT,
    FULL_NAME         VARCHAR(100) NOT NULL,
    PHYSICAL_ADDRESS  VARCHAR(150),
    SALUTATION        VARCHAR(10)
);

CREATE TABLE PELICULAS (
    ID_PELICULA  INT PRIMARY KEY AUTO_INCREMENT,
    TITULO       VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE ALQUILERES (
    ID_CLIENTE   INT NOT NULL,
    ID_PELICULA  INT NOT NULL,
    PRIMARY KEY (ID_CLIENTE, ID_PELICULA),
    FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTES(ID_CLIENTE),
    FOREIGN KEY (ID_PELICULA) REFERENCES PELICULAS(ID_PELICULA)
);

-- Nota: en los datos originales "Robert Phil" aparece con dos direcciones
-- distintas (3rd Street 34 y 5th Avenue). Se asume error de captura y se
-- deja una sola dirección por cliente.
INSERT INTO CLIENTES (FULL_NAME, PHYSICAL_ADDRESS, SALUTATION) VALUES
('Janet Jones','First Street Plot No 4','Ms.'),
('Robert Phil','3rd Street 34','Mr.');

INSERT INTO PELICULAS (TITULO) VALUES
('Pirates of the Caribbean'),
('Clash of the Titans'),
('Forgetting Sarah Marshal'),
('Daddy''s Little Girls');

INSERT INTO ALQUILERES VALUES
(1,1),(1,2),
(2,3),(2,4),(2,2);
