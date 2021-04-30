CREATE DATABASE IF NOT EXISTS Biblioteca;
USE Biblioteca;

DROP TABLE IF EXISTS Escribe;
DROP TABLE IF EXISTS Autor;
DROP TABLE IF EXISTS Libro;

CREATE TABLE Autor(
    id             INT                     NOT NULL     AUTO_INCREMENT,
    nombre    VARCHAR(30)  NOT NULL,
    apellido    VARCHAR(30)  NOT NULL,
    nacionalidad    VARCHAR(30)  NOT NULL,
    residencia   VARCHAR(30)    NULL,
    PRIMARY KEY (id)
);



CREATE TABLE Libro(
    isbn  VARCHAR(13)   NOT NULL,
    titulo  VARCHAR(100)   NOT NULL,
    editorial  VARCHAR(100)   NOT NULL,
    precio    DECIMAL(6,2)  UNSIGNED  NULL,
    PRIMARY KEY (isbn)
);

CREATE TABLE Escribe(
    año   YEAR                 NOT NULL,
    isbn  VARCHAR(13)   NOT NULL,
    id      INT                     NOT NULL,
    PRIMARY KEY (isbn,id),
    FOREIGN KEY (isbn) REFERENCES Libro(isbn) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id) REFERENCES Autor(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- INSERT INTO Escribe VALUES(`1997`,`9789877253146`, `Padre rico,Padre Pobre`,`Debolsillo`,1300);
-- INSERT INTO Escribe VALUES(`1997`,`9781907545009`, `Harry Potter and the Philosopher's Stone`,`Bloomsbury Publishing `,1000);




-- 2 En general, las búsquedas en la base de datos se realizan por tı́tulo de libro o apellido de autor.
-- Modificar la base de datos para agilizar estos procedimientos.
CREATE INDEX  apellido_index ON Autor(apellido);
CREATE INDEX  titulo_index ON Libro(titulo);

INSERT INTO Autor VALUES(DEFAULT, 'Joanne','Rowling','Inglaterra','Killiechassie');
INSERT INTO Autor VALUES(DEFAULT, 'Robert','Kiyosaki','Estados Unidos','Hawái');
INSERT INTO Autor VALUES(DEFAULT, 'Dennis','Ritchie','Estados Unidos',NULL);

INSERT INTO Libro VALUES('9780131101630', 'The C Programming Language','Prentice Hall',5000);
INSERT INTO Libro VALUES('9789877253146', 'Padre rico,Padre Pobre','Debolsillo',1300);
INSERT INTO Libro VALUES('9781907545009', 'Harry Potter and the Philosophers Stone','Bloomsbury Publishing',1000);

-- PREGUNTAS
-- Que sucede si 2 personas se llaman igual
INSERT INTO Escribe VALUES('1978',
    (SELECT isbn FROM Libro WHERE titulo = 'The C Programming Language'   ),
    (SELECT id FROM  Autor   WHERE   nombre ='Dennis' and apellido = 'Ritchie')
);
INSERT INTO Escribe VALUES('1978',
    (SELECT isbn FROM Libro WHERE titulo = 'Padre rico,Padre Pobre'   ),
    (SELECT id FROM  Autor   WHERE   nombre ='Robert' and apellido = 'Kiyosaki')
);
INSERT INTO Escribe VALUES('1978',
    (SELECT isbn FROM Libro WHERE titulo = 'Harry Potter and the Philosophers Stone'   ),
    (SELECT id FROM  Autor   WHERE   nombre ='Joanne' and apellido = 'Rowling')
);

-- EJ 4
-- a
UPDATE Autor SET  residencia = 'Buenos Aires' WHERE nombre = 'Robert' and apellido = 'Kiyosaki';
-- b
UPDATE Libro SET  precio = ROUND(precio*0.10 + precio, 2) WHERE editorial = 'Bloomsbury Publishing';
-- c
UPDATE Libro,Autor  SET precio = ROUND(precio*0.2 + precio, 2) WHERE nacionalidad <> 'Argentina' and precio < 200;
UPDATE Libro, Autor SET precio = ROUND(precio*0.1 + precio, 2) WHERE nacionalidad <> 'Argentina' and precio >= 200;
-- c
UPDATE  Libro, Autor
SET      precio = IF( precio > 200, ROUND( precio * 0.10 +  precio ,2), ROUND( precio *0.20 +  precio ,2))
WHERE   nacionalidad  <>  'Argentina';
-- d
DELETE FROM  Libro  WHERE isbn IN (SELECT isbn FROM Escribe WHERE año = '1978' )
