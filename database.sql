-- Sistema de Gestión Académica
DROP DATABASE IF EXISTS sistema_academico;
CREATE DATABASE sistema_academico;
USE sistema_academico;


-- TABLA DE CARRERAS
CREATE TABLE carreras (
    id_carrera INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    duracion_anios INT NOT NULL
);


-- TABLA DE MATERIAS
CREATE TABLE materias (
    id_materia INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    anio_nivel INT NOT NULL, -- 1ro, 2do, 3ro, etc.
    carga_horaria INT NOT NULL,
    id_carrera INT,
    FOREIGN KEY (id_carrera) REFERENCES carreras(id_carrera)
);


--TABLA DE ALUMNOS
CREATE TABLE alumnos (
    id_alumno INT AUTO_INCREMENT PRIMARY KEY,
    legajo INT UNIQUE NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    fecha_ingreso DATE NOT NULL,
    estado ENUM('Activo', 'Egresado', 'Baja') DEFAULT 'Activo'
);


-- TABLA DE CURSADAS Alumno - Materia
-- Registra si el alumno regularizó la materia para poder rendir final
CREATE TABLE cursadas (
    id_cursada INT AUTO_INCREMENT PRIMARY KEY,
    id_alumno INT NOT NULL,
    id_materia INT NOT NULL,
    anio_cursado YEAR NOT NULL,
    nota_parcial_1 DECIMAL(4,2),
    nota_parcial_2 DECIMAL(4,2),
    estado ENUM('Regular', 'Promocionado', 'Libre') NOT NULL,
    FOREIGN KEY (id_alumno) REFERENCES alumnos(id_alumno),
    FOREIGN KEY (id_materia) REFERENCES materias(id_materia)
);


-- TABLA DE FINALES (Exámenes Finales)
CREATE TABLE finales (
    id_final INT AUTO_INCREMENT PRIMARY KEY,
    id_alumno INT NOT NULL,
    id_materia INT NOT NULL,
    fecha DATE NOT NULL,
    nota DECIMAL(4,2) NOT NULL,
    libro_acta VARCHAR(20),
    folio INT,
    FOREIGN KEY (id_alumno) REFERENCES alumnos(id_alumno),
    FOREIGN KEY (id_materia) REFERENCES materias(id_materia)
);


--Datos de prueba
INSERT INTO carreras (nombre, duracion_anios) VALUES 
('Tecnicatura Universitaria en Programación', 2),
('Ingeniería en Sistemas', 5);

INSERT INTO materias (nombre, anio_nivel, carga_horaria, id_carrera) VALUES 
('Programación I', 1, 6, 1),
('Sistemas de Procesamiento de Datos', 1, 4, 1),
('Matemática', 1, 5, 1),
('Programación II', 1, 6, 1),
('Inglés Técnico', 1, 3, 1),
('Base de Datos', 2, 5, 1);

INSERT INTO alumnos (legajo, nombre, apellido, email, fecha_ingreso) VALUES 
(25001, 'Hernan', 'Barrera', 'hernan.barrera@email.com', '2024-03-01'),
(25002, 'Lionel', 'Messi', 'lio.messi@email.com', '2024-03-01'),
(25003, 'Elon', 'Musk', 'elon.musk@email.com', '2025-03-01');

--Hernan curso y aprobo todo 1er año
INSERT INTO cursadas (id_alumno, id_materia, anio_cursado, nota_parcial_1, nota_parcial_2, estado) VALUES
(1, 1, 2024, 8, 9, 'Regular'),
(1, 2, 2024, 7, 7, 'Promocionado'),
(1, 3, 2024, 6, 8, 'Regular');

--Finales rendidos por mi
INSERT INTO finales (id_alumno, id_materia, fecha, nota, libro_acta, folio) VALUES
(1, 1, '2024-12-15', 9, 'A-2024', 101),
(1, 3, '2024-12-20', 4, 'A-2024', 102);
