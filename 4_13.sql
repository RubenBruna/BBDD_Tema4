-- 1
SELECT NOMBRE --DATOS_PERSONALES.NOMBRE
FROM DATOS_PERSONALES, PROFESOR, IDIOMA, IDIOMAS_PROF -- Se escriben en el FROM todas las tablas que se van a usar
WHERE TIPO = 'PROFESOR'
AND DESCRIPCION = 'Español'
AND DATOS_PERSONALES.DNI = PROFESOR.DNI
AND PROFESOR.DNI = IDIOMAS_PROF.DNI
AND IDIOMA.COD_IDIOMA = IDIOMAS_PROF.COD_IDIOMA;

-- 2
SELECT ASIGNATURA.NOMBRE
FROM CICLO_FORM, ASIGNATURA
WHERE CICLO_FORM.NOMBRE = 'DAM'
AND CICLO_FORM.COD_CICLO = ASIGNATURA.COD_CICLO;

-- 3
SELECT PROFESOR.CUENTA, DATOS_PERSONALES.NOMBRE
FROM PROFESOR, DATOS_PERSONALES
WHERE PROFESOR.DNI = DATOS_PERSONALES.DNI;
-- No hace falta comprobar que el tipo es profesor porque todas las tablas de profesor relacionadas con datos personales son profesores

/* Muestra todos los campos de la tabla profesores, y todos los campos de la tabla alumnos
SELECT * --PROFESOR.CUENTA, DATOS_PERSONALES.NOMBRE
FROM PROFESOR, DATOS_PERSONALES
WHERE PROFESOR.DNI = DATOS_PERSONALES.DNI; -- WHERE pone filtros
*/

/* A y D son alias
SELECT D.NOMBRE
FROM ALUMNO A, DATOS_PERSONALES D
WHERE A.DNI = D.DNI;
*/

-- 4
SELECT *
FROM ALUMNO, DATOS_PERSONALES
WHERE ALUMNO.DNI = DATOS_PERSONALES.DNI;

-- 5
SELECT *
FROM PROFESOR, DATOS_PERSONALES
WHERE PROFESOR.DNI = DATOS_PERSONALES.DNI;

-- 6
SELECT ALUMNO.EMAIL, DATOS_PERSONALES.NOMBRE
FROM ALUMNO, DATOS_PERSONALES
WHERE ALUMNO.DNI = DATOS_PERSONALES.DNI;

-- 7
SELECT ALUMNO.EMAIL, DATOS_PERSONALES.NOMBRE
FROM ALUMNO, DATOS_PERSONALES, ASIGNATURA, MATRICULA
WHERE ASIGNATURA.NOMBRE = 'Empresa'
AND ALUMNO.DNI = DATOS_PERSONALES.DNI
AND DATOS_PERSONALES.DNI = MATRICULA.DNI
AND MATRICULA.COD_ASIG = ASIGNATURA.COD_ASIG;

-- 8 (siguiente pägina)
SELECT DISTINCT DATOS_PERSONALES.NOMBRE, CICLO_FORM.NOMBRE -- DISTINCT: No salen los repetidos. Pedro tiene dos asignaturas de DAM
FROM DATOS_PERSONALES, CICLO_FORM, MATRICULA, ASIGNATURA
WHERE DATOS_PERSONALES.DNI = MATRICULA.DNI
AND MATRICULA.COD_ASIG = ASIGNATURA.COD_ASIG
AND ASIGNATURA.COD_CICLO = CICLO_FORM.COD_CICLO;

-- 9
SELECT DATOS_PERSONALES.NOMBRE, ASIGNATURA.NOMBRE
FROM DATOS_PERSONALES, MATRICULA, ASIGNATURA
WHERE DATOS_PERSONALES.NOMBRE = 'Pedro';

-- 10
SELECT CICLO_FORM.NOMBRE CICLO
FROM CICLO_FORM
WHERE CICLO_FORM.TIPO = 'GRADO SUPERIOR';
-- La unidad mínima es el registro o campo (cada fila es un registro: DAM, ARI)

-- 11
SELECT ASIGNATURA.NOMBRE AS NOMBRE_ASIGNATURA, CICLO_FORM.NOMBRE AS NOMBRE_CICLO_FORM
FROM ASIGNATURA, CICLO_FORM
WHERE ASIGNATURA.COD_CICLO = CICLO_FORM.COD_CICLO;

-- 12
SELECT A.NOMBRE ASIGNATURA, A.NUM_HORAS HORAS
FROM ASIGNATURA A
WHERE NUM_HORAS < 200;

-- 13
SELECT *
FROM DATOS_PERSONALES
WHERE DATOS_PERSONALES.NOMBRE = 'ANDREA';

UPDATE DATOS_PERSONALES
SET DATOS_PERSONALES.AP2 = NULL
WHERE DATOS_PERSONALES.NOMBRE = 'ANDREA';

-- 14
SELECT ASIGNATURA.NOMBRE
FROM MATRICULA, ASIGNATURA
WHERE MATRICULA.COD_ASIG = ASIGNATURA.COD_ASIG
AND ASIGNATURA.NOMBRE = 'Programación';

DELETE MATRICULA WHERE MATRICULA.COD_ASIG = 5; -- DELETE FROM / DELETE
/* Subconsulta:
DELETE MATRICULA WHERE MATRICULA.COD_ASIG =
    (SELECT COD_ASIG
    FROM ASIGNATURA
    WHERE NOMBRE = 'Programación')
*/

-- 15
-- La PK es el último registro que se elimina: Primero los que tienen el valor como FK y luego el que lo tiene como PK (ON DELETE CASCADE lo hace automáticamente)
SELECT ASIGNATURA.*
FROM MATRICULA, ASIGNATURA
WHERE MATRICULA.COD_ASIG = ASIGNATURA.COD_ASIG
AND ASIGNATURA.NOMBRE = 'Empresa';

DELETE FROM MATRICULA WHERE MATRICULA.COD_ASIG = 1;
DELETE FROM ASIGNATURA WHERE ASIGNATURA.COD_ASIG = 1;

-- 16
SELECT *
FROM ASIGNATURA
WHERE ASIGNATURA.NOMBRE = 'Bases de datos';

UPDATE ASIGNATURA
SET ASIGNATURA.NOMBRE = 'BBDD'
WHERE ASIGNATURA.NOMBRE = 'Bases de datos';

--17
SELECT *
FROM CICLO_FORM
WHERE CICLO_FORM.TIPO = 'GRADO MEDIO';

INSERT INTO CICLO_FORM(COD_CICLO, NOMBRE, TIPO) VALUES(6365, 'ELEC', 'GRADO MEDIO');

-- 18
SELECT *
FROM ASIGNATURA, DATOS_PERSONALES
WHERE DATOS_PERSONALES.DNI = '89621477A';

INSERT INTO ASIGNATURA(COD_ASIG, NOMBRE, NUM_HORAS, DNI_PROFESOR, COD_CICLO) VALUES(6,'Circuitos Baja Potencia',100,'89621477A',6365);

-- 19
SELECT DATOS_PERSONALES.NOMBRE, MATRICULA.COD_ASIG
FROM MATRICULA, DATOS_PERSONALES
WHERE DATOS_PERSONALES.NOMBRE = 'PEDRO';

UPDATE MATRICULA
SET MATRICULA.COD_ASIG = 6
WHERE DATOS_PERSONALES.NOMBRE = 'PEDRO'
AND MATRICULA.COD_ASIG = 2;

-- 20
SELECT COD_IDIOMA
FROM IDIOMA, IDIOMAS_PROF, DATOS_PERSONALES
--WHERE IDIOMA.COD_IDIOMA = 50
WHERE DATOS_PERSONALES.NOMBRE = "Jesús"
AND DATOS_PERSONALES.DNI = IDIOMAS_PROF.DNI
AND IDIOMA.COD_IDIOMA = 50;

INSERT INTO IDIOMA(COD_IDIOMA, DESCRIPCION) VALUES(50, 'Alemán');
INSERT INTO IDIOMAS_PROF(COD_IDIOMA, DNI) VALUES(50, '44103779F');