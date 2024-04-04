-- Creación de la base de datos Alke Wallet
CREATE DATABASE IF NOT EXISTS `Alke_Wallet`;
USE `Alke_Wallet`;

-- Creación de la tabla Usuario
CREATE TABLE IF NOT EXISTS `Usuario` (
    `user_id` INT AUTO_INCREMENT PRIMARY KEY,
    `nombre` VARCHAR(100) NOT NULL,
    `correo_electronico` VARCHAR(100) NOT NULL UNIQUE,
    `contrasena` VARCHAR(100) NOT NULL,
    `saldo` DECIMAL(10, 2) NOT NULL DEFAULT 0.00
);

-- Creación de la tabla Moneda
CREATE TABLE IF NOT EXISTS `Moneda` (
    `currency_id` INT AUTO_INCREMENT PRIMARY KEY,
    `currency_name` VARCHAR(50) NOT NULL,
    `currency_symbol` VARCHAR(10) NOT NULL
);

-- Creación de la tabla Transacción
CREATE TABLE IF NOT EXISTS `Transaccion` (
    `transaction_id` INT AUTO_INCREMENT PRIMARY KEY,
    `sender_user_id` INT NOT NULL,
    `receiver_user_id` INT NOT NULL,
    `importe` DECIMAL(10, 2) NOT NULL,
    `transaction_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `currency_id` INT NOT NULL,
    FOREIGN KEY (`sender_user_id`) REFERENCES `Usuario`(`user_id`),
    FOREIGN KEY (`receiver_user_id`) REFERENCES `Usuario`(`user_id`),
    FOREIGN KEY (`currency_id`) REFERENCES `Moneda`(`currency_id`)
);

-- Inserción de datos de prueba en la tabla Moneda
INSERT INTO `Moneda` (`currency_name`, `currency_symbol`)
VALUES ('Dólar estadounidense', 'USD'),
       ('Euro', 'EUR'),
       ('Bitcoin', 'BTC');

-- Inserción de datos de prueba en la tabla Usuario
INSERT INTO `Usuario` (`nombre`, `correo_electronico`, `contrasena`, `saldo`)
VALUES ('Juan Pérez', 'juan.perez@example.com', 'contraseña123', 100.00),
       ('Ana Gómez', 'ana.gomez@example.com', 'contraseña456', 200.00);

-- Inserción de datos de prueba en la tabla Transaccion
INSERT INTO `Transaccion` (`sender_user_id`, `receiver_user_id`, `importe`, `currency_id`)
VALUES (1, 2, 50.00, 1),
       (2, 1, 30.00, 2);
       
-- Consulta para obtener el nombre de la moneda elegida por un usuario específico
SELECT m.currency_name
FROM Moneda m
JOIN Transaccion t ON m.currency_id = t.currency_id
JOIN Usuario u ON u.user_id = t.sender_user_id
WHERE u.nombre = 'Juan Pérez';

-- Consulta para obtener todas las transacciones registradas
SELECT * FROM Transaccion;

-- Consulta para obtener todas las transacciones realizadas por un usuario específico
SELECT * FROM Transaccion
WHERE sender_user_id = (SELECT user_id FROM Usuario WHERE nombre = 'Juan Pérez');       

-- Sentencia DML para modificar el campo correo electrónico de un usuario específico
UPDATE Usuario
SET correo_electronico = 'nuevo_correo_juan@example.com'
WHERE nombre = 'Juan Pérez';

-- Sentencia para eliminar los datos de una transacción (eliminado de la fila completa)
DELETE FROM Transaccion
WHERE transaction_id = 1; -- Reemplazar 1 por el ID de la transacción a eliminar