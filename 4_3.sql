CREATE TABLE DIRECTOR(
    DNI VARCHAR(9),
    NOMBRE VARCHAR(40) NOT NULL,
    PR_APELLIDO VARCHAR(40) NOT NULL,
    SG_APELLIDO VARCHAR(40),
    DOMICILIO VARCHAR(40) NOT NULL,
    TELEFONO NUMBER(9) NOT NULL,
    EMAIL VARCHAR(40),
    CONSTRAINT PK_DIRECTOR PRIMARY KEY(DNI)
);

CREATE TABLE SUPERMERCADO(
    COD_SUP NUMBER(4),
    DIRECCION VARCHAR(40) NOT NULL,
    SUPERFICIE NUMBER(4) NOT NULL,
    ES_ALQUILER BOOLEAN NOT NULL,
    FECHA DATE,
    DNI_DIRECTOR VARCHAR(9) NOT NULL,
    CONSTRAINT PK_SUP PRIMARY KEY(COD_SUP),
    CONSTRAINT FK_DIRECTOR FOREIGN KEY(DNI_DIRECTOR) REFERENCES DIRECTOR(DNI)
);

CREATE TABLE VENDEDOR(
    DNI VARCHAR(9),
    NOMBRE VARCHAR(40) NOT NULL,
    PR_APELLIDO VARCHAR(40) NOT NULL,
    SG_APELLIDO VARCHAR(40),
    DOMICILIO VARCHAR(40) NOT NULL,
    TELEFONO NUMBER(9) NOT NULL,
    EMAIL VARCHAR(40),
    COD_SUP VARCHAR(9) NOT NULL,
    CONSTRAINT PK_VENDEDOR PRIMARY KEY(DNI),
    CONSTRAINT FK_SUPERMERCADO FOREIGN KEY(COD_SUP) REFERENCES SUPERMERCADO(COD_SUP)
);

CREATE TABLE CLIENTE(
    DNI VARCHAR(9),
    NOMBRE VARCHAR(40) NOT NULL,
    PR_APELLIDO VARCHAR(40) NOT NULL,
    SG_APELLIDO VARCHAR(40),
    DOMICILIO VARCHAR(40) NOT NULL,
    TELEFONO NUMBER(9) NOT NULL,
    EMAIL VARCHAR(40),
    CONSTRAINT PK_CLIENTE PRIMARY KEY(DNI),
);

CREATE TABLE VENTA(
    COD_VENTA NUMBER(4),
    FECHA DATE,
    DNI_VEND VARCHAR(9),
    DNI_CL VARCHAR(9),
    CONSTRAINT PK_VENTA PRIMARY KEY(COD_VENTA),
    CONSTRAINT FK_VENDEDOR FOREIGN KEY(DNI_VEND) REFERENCES VENDEDOR(DNI),
    CONSTRAINT FK_CLIENTE FOREIGN KEY(DNI_CL) REFERENCES CLIENTE(DNI)
);

CREATE TABLE PRODUCTO(
    COD_PRODUCTO NUMBER(4),
    DESCRIPCION VARCHAR(40) NOT NULL,
    FAMILIA VARCHAR(40) NOT NULL,
    GENERO VARCHAR(40) NOT NULL,
    DESCUENTO NUMBER(5,2),
    IVA NUMBER(5,2) NOT NULL,
    CONSTRAINT PK_PRODUCTO PRIMARY KEY(COD_PRODUCTO)
);

CREATE TABLE PRECIO(
    COD_PROD NUMBER(4),
    FECHA DATE,
    CONSTRAINT PK_PRECIO PRIMARY KEY(COD_PROD, FECHA),
    CONSTRAINT FK_PRODUCTO FOREIGN KEY(COD_PROD) REFERENCES PRODUCTO(COD_PROD)
);

CREATE TABLE LINEA_VENTA(
    COD_VENTA NUMBER(4),
    NUM_LINEA NUMBER(4),
    COD_PROD NUMBER(4) NOT NULL,
    FECHA DATE,
    CANTIDAD NUMBER(2) NOT NULL,
    CONSTRAINT PK_LINEA_VENTA PRIMARY KEY(COD_VENTA, NUM_LINEA),
    CONSTRAINT FK_PROD FOREIGN KEY(COD_PROD, FECHA) REFERENCES PRECIO(COD_PROD, FECHA)
);

CREATE TABLE DEVOLUCION(
    COD_VENTA NUMBER(4),
    NUM_LINEA NUMBER(4),
    FECHA DATE,
    ESTADO VARCHAR(40),
    TIPO_DEV VARCHAR(40),
    CONSTRAINT PK_DEVOLUCION PRIMARY KEY(COD_VENTA, NUM_LINEA, FECHA),
    CONSTRAINT FK_LINEA_VENTA FOREIGN KEY(COD_VENTA, NUM_LINEA) REFERENCES LINEA_VENTA(COD_VENTA, NUM_LINEA)
);