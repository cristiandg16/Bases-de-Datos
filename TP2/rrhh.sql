/* Ejercicio 1 */

CREATE DATABASE IF NOT EXISTS aramirez_RecursosHumanos;

USE aramirez_RecursosHumanos;

DROP TABLE IF EXISTS Realiza;
DROP TABLE IF EXISTS Empleado;
DROP TABLE IF EXISTS Curso;

CREATE TABLE Empleado (
  id		INT		NOT NULL	AUTO_INCREMENT,
  nombre	VARCHAR(20)	NOT NULL,
  apellido	VARCHAR(30)	NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE Curso (
  código	CHAR(7)		NOT NULL,
  nombre	VARCHAR(30)	NOT NULL,
  tipo		VARCHAR(15)	NOT NULL	DEFAULT 'interno',
  PRIMARY KEY (código)
);

CREATE TABLE Realiza (
  id		INT		NOT NULL,
  código	CHAR(7)		NOT NULL,
  PRIMARY KEY (id, código),
  FOREIGN KEY (id) REFERENCES Empleado(id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (código) REFERENCES Curso(código) ON DELETE CASCADE ON UPDATE CASCADE
);


/* Ejercicio 2 */

ALTER TABLE Empleado
ADD ingreso DATE,
MODIFY nombre VARCHAR(30) NOT NULL;


/* Ejercicio 3 */

CREATE INDEX apellido_idx ON Empleado(apellido);


/* Ejercicio 4 */

INSERT INTO Empleado (nombre, apellido, id, ingreso) VALUES ('Clara', 'Toledo', DEFAULT, '1998-03-02');
INSERT INTO Empleado VALUES (DEFAULT, 'Roberto', 'Ocampo', '2002-10-07');
INSERT INTO Empleado VALUES (DEFAULT, 'José', 'Ruiz', '2007-08-06');
INSERT INTO Empleado VALUES (DEFAULT, 'Ana', 'Moretti', '2020-03-02');

INSERT INTO Curso VALUES ('S-123-1', 'Prevención COVID', DEFAULT);
INSERT INTO Curso VALUES ('S-100-3', 'Primeros Auxilios', DEFAULT);
INSERT INTO Curso VALUES ('M-150-2', 'Marketing digital', 'externo');

INSERT INTO Realiza VALUES ((SELECT id FROM Empleado WHERE nombre = 'Clara' AND apellido = 'Toledo'), 'S-123-1');
INSERT INTO Realiza VALUES ((SELECT id FROM Empleado WHERE nombre = 'Clara' AND apellido = 'Toledo'), 'S-100-3');
INSERT INTO Realiza VALUES ((SELECT id FROM Empleado WHERE nombre = 'Clara' AND apellido = 'Toledo'), 'M-150-2');
INSERT INTO Realiza VALUES ((SELECT id FROM Empleado WHERE nombre = 'Roberto' AND apellido = 'Ocampo'), 'S-100-3');
INSERT INTO Realiza VALUES ((SELECT id FROM Empleado WHERE nombre = 'José' AND apellido = 'Ruiz'), 'S-100-3');
INSERT INTO Realiza VALUES ((SELECT id FROM Empleado WHERE nombre = 'José' AND apellido = 'Ruiz'), 'S-123-1');
INSERT INTO Realiza VALUES ((SELECT id FROM Empleado WHERE nombre = 'Ana' AND apellido = 'Moretti'), 'S-123-1');


/* Ejercicio 5 */

DELETE FROM Empleado
WHERE apellido = 'Ocampo'
AND   nombre = 'Roberto';

UPDATE Empleado
SET nombre = 'Ana Emilia'
WHERE nombre = 'Ana'
AND   apellido = 'Moretti';


/* Ejercicio 6 */

SELECT nombre, apellido
FROM Empleado
WHERE ingreso < '2015-01-01';


/* Ejercicio 7 */

SELECT Empleado.nombre, apellido
FROM Empleado, Curso, Realiza
WHERE Empleado.id = Realiza.id
AND   Curso.código = Realiza.código
AND   Curso.nombre = 'Prevención COVID';


/* Ejercicio 8 */

SELECT nombre, apellido
FROM Empleado
WHERE id IN (SELECT id
             FROM Realiza
             GROUP BY id
             HAVING COUNT(*) = (SELECT COUNT(*)
                                FROM Curso));
