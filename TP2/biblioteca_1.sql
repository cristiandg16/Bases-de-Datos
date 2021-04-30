CREATE DATABASE IF NOT EXISTS Biblioteca;

USE Biblioteca;

DROP TABLE IF EXISTS Escribe;
DROP TABLE IF EXISTS Autor;
DROP TABLE IF EXISTS Libro;

CREATE TABLE Autor (
    id              INT             NOT NULL    AUTO_INCREMENT,
    nombre          VARCHAR(30)     NOT NULL,
    apellido        VARCHAR(30)     NOT NULL,
    nacionalidad    VARCHAR(30)     NOT NULL,
    residencia      VARCHAR(30)     NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE Libro(
    isbn            CHAR(11)        NOT NULL,
    titulo          VARCHAR(30)     NOT NULL,
    editorial       VARCHAR(30)     NOT NULL,
    precio          DECIMAL(6,2)    NOT NULL,
    PRIMARY KEY(isbn)
);

CREATE TABLE Escribe(
    año             DATETIME        NOT NULL,
    id              INT             NOT NULL,
    isbn            VARCHAR(13)     NOT NULL,
    PRIMARY KEY (isbn,id),
    FOREIGN KEY (isbn) REFERENCES Libro(isbn) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id)   REFERENCES Autor(id) ON DELETE CASCADE ON UPDATE CASCADE
);




