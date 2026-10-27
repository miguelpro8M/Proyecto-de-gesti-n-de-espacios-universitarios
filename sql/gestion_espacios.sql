CREATE DATABASE IF NOT EXISTS gestion_espacios
    CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE gestion_espacios;

CREATE TABLE IF NOT EXISTS salones (
                                       id          INT AUTO_INCREMENT PRIMARY KEY,
                                       nombre      VARCHAR(10) NOT NULL UNIQUE,
    edificio    VARCHAR(5)  NOT NULL,
    piso        INT         NOT NULL,
    tipo        VARCHAR(20) NOT NULL,
    tipo_nombre VARCHAR(40) NOT NULL,
    capacidad   INT         NOT NULL,
    estado      VARCHAR(15) NOT NULL DEFAULT 'Disponible'
    );

INSERT IGNORE INTO salones (nombre, edificio, piso, tipo, tipo_nombre, capacidad, estado) VALUES
('A-101', 'A', 1, 'aula',         'Aula',                 30,  'Disponible'),
('A-102', 'A', 1, 'computadores', 'Sala de computadores', 40,  'Ocupado'),
('A-201', 'A', 2, 'aula',         'Aula',                 35,  'Disponible'),
('B-101', 'B', 1, 'laboratorio',  'Laboratorio',          25,  'Disponible'),
('B-201', 'B', 2, 'computadores', 'Sala de computadores', 30,  'Ocupado'),
('C-301', 'C', 3, 'auditorio',    'Auditorio',            100, 'Disponible'),
('C-302', 'C', 3, 'laboratorio',  'Laboratorio',          30,  'Disponible'),
('C-303', 'C', 3, 'aula',         'Aula',                 40,  'Ocupado');

CREATE USER IF NOT EXISTS 'gestion_user'@'localhost' IDENTIFIED BY 'gestion123';
GRANT ALL PRIVILEGES ON gestion_espacios.* TO 'gestion_user'@'localhost';
FLUSH PRIVILEGES;