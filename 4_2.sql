CREATE TABLE FABRICANTE(
    COD_FAB NUMBER(4) CONSTRAINT PK_PROFESOR PRIMARY KEY, -- No es necesario añadir NOT NULL a una PK (es automático)
    FABRICANTE VARCHAR(40) NOT NULL
);

CREATE TABLE MARCA(
    COD_MARCA NUMBER(4) CONSTRAINT PK_MARCA PRIMARY KEY,
    MARCA VARCHAR(30) NOT NULL
);

CREATE TABLE VEHICULO(
    COD_VEHICULO NUMBER(4) CONSTRAINT PK_VEHICULO PRIMARY KEY,
    MODELO VARCHAR(30) NOT NULL,
    TIPO VARCHAR(30) NOT NULL,
    COLOR VARCHAR(30) NOT NULL,
    -- F · COD_FAB > FABRICANTE, F · COD_MARCA > MARCA
    COD_FAB NUMBER(4) NOT NULL,
    COD_MARCA NUMBER(4) NOT NULL,
    CONSTRAINT FK_COD_FAB FOREIGN KEY(COD_FAB) REFERENCES FABRICANTE(COD_FAB),
    CONSTRAINT FK_COD_MARCA FOREIGN KEY(COD_MARCA) REFERENCES MARCA(COD_MARCA)
);

CREATE TABLE CLIENTE(
    DNI_CLIENTE NUMBER(9) CONSTRAINT PK_CLIENTE PRIMARY KEY,
    NOMBRE VARCHAR(40) NOT NULL,
    AP1 VARCHAR(40) NOT NULL,
    AP2 VARCHAR(40),
    DOMICILIO VARCHAR(30) NOT NULL,
    NUM_TARJETA NUMBER(10) NOT NULL
);

CREATE TABLE CURSO(
    COD_CURSO NUMBER(4) CONSTRAINT PK_CURSO PRIMARY KEY,
    DESCRIPCION VARCHAR(30) NOT NULL,
    NUM_HORAS NUMBER(3) NOT NULL,
    FECHA DATE NOT NULL
);

CREATE TABLE EMPLEADO(
    DNI_EMP NUMBER(9) CONSTRAINT PK_EMPLEADO PRIMARY KEY,
    NOMBRE VARCHAR(40) NOT NULL,
    AP1 VARCHAR(40) NOT NULL,
    AP2 VARCHAR(40),
    DOMICILIO VARCHAR(30) NOT NULL,
    NUM_CUENTA NUMBER(10) NOT NULL
);

CREATE TABLE CURSO_EMPLEADO(
    -- PF · COD_CURSO > CURSO, PF · DNI > EMPLEADO
    COD_CURSO NUMBER(4),
    DNI_EMP VARCHAR(9),
    CONSTRAINT PK_CURSO_EMPLEADO PRIMARY KEY(COD_CURSO, DNI_EMP),
    CONSTRAINT FK_COD_CURSO FOREIGN KEY(COD_CURSO) REFERENCES CURSO(COD_CURSO),
    CONSTRAINT FK_DNI_EMP FOREIGN KEY(DNI_EMP) REFERENCES EMPLEADO(DNI_EMP)
);

CREATE TABLE ALQUILER(
    COD_ALQUILER NUMBER(4) CONSTRAINT PK_ALQUILER PRIMARY KEY,
    FECHA DATE NOT NULL,
    NUM_DIAS NUMBER(4) NOT NULL,
    KM_ACTUAL NUMBER(5) NOT NULL,
    KM_ENTREGA NUMBER(5) NOT NULL,
    -- F · COD_VEHICULO > VEHICULO, F · DNI_CLIENTE > CLIENTE, F · DNI_EMP > EMPLEADO
    COD_VEHICULO NUMBER(4) NOT NULL,
    DNI_CLIENTE VARCHAR(9) NOT NULL,
    DNI_EMP VARCHAR(9) NOT NULL,
    CONSTRAINT FK_COD_VEHICULO FOREIGN KEY COD_VEHICULO REFERENCES VEHICULO(COD_VEHICULO),
    CONSTRAINT FK_DNI_CLIENTE FOREIGN KEY DNI_CLIENTE REFERENCES CLIENTE(DNI_CLIENTE),
    CONSTRAINT FK_DNI_EMP FOREIGN KEY DNI_EMP REFERENCES EMPLEADO(DNI_EMP)

);

CREATE TABLE OFICINA(
    COD_OFICINA NUMBER(4) CONSTRAINT PK_OFICINA PRIMARY KEY,
    DOMICILIO VARCHAR(30) NOT NULL,
    TELEFONO NUMBER(9) NOT NULL
);

CREATE TABLE OFICINAS_ALQ(
    -- PF · COD_ALQUILER > ALQUILER, PF · COD_OFICINA > OFICINA
    COD_ALQUILER NUMBER(4),
    COD_OFICINA NUMBER(4),
    CONSTRAINT PK_OFICINAS_ALQ PRIMARY KEY(COD_AQLUILER, COD_OFICINA),
    CONSTRAINT FK_COD_ALQUILER FOREIGN KEY(COD_ALQUILER) REFERENCES ALQUILER(COD_ALQUILER),
    CONSTRAINT FK_COD_OFICINA FOREIGN KEY(COD_OFICINA) REFERENCES OFICINA(COD_OFICINA)
);