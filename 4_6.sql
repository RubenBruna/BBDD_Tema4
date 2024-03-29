CREATE TABLE DIRECTOR(
    DNI VARCHAR(9),
    NOMBRE VARCHAR(30) NOT NULL,
    PRAPELLIDO VARCHAR(30) NOT NULL,
    SGAPELLIDO VARCHAR(30),
    DOMICILIO VARCHAR(30) NOT NULL,
    TELEFONO NUMBER(9) NOT NULL,
    EMAIL VARCHAR(30),
    CONSTRAINT PK_DIRECTOR PRIMARY KEY(DNI)
);

CREATE TABLE SUPERMERCADO(
    COD_SUP NUMBER(4),
    DIRECCION VARCHAR(30) NOT NULL,
    SUPERFICIE NUMBER(4) NOT NULL,
    ESALQUILER CHAR(1) NOT NULL,
    FECHA DATE, -- No necesitan marcarse como NOT NULL, porque siempre tienen un valor, por defecto 01/01/1970
    DNI_DIRECTOR NOT NULL,
    CONSTRAINT PK_SUP PRIMARY KEY(COD_SUP),
    CONSTRAINT FK_DIRECTOR FOREIGN KEY(DNI_DIRECTOR) REFERENCES DIRECTOR(DNI), -- El nombre de la FK debe ser el de la tabla (entidad) a la que hace referencia
    CONSTRAINT CK_SUPERMERCADO CHECK(SUPERFICIE > 0 AND ESALQUILER IN ('S', 's', 'N', 'n'))
);

CREATE TABLE VENDEDOR(
    DNI VARCHAR(9),
    NOMBRE VARCHAR(30) NOT NULL,
    PRAPELLIDO VARCHAR(30) NOT NULL,
    SGAPELLIDO VARCHAR(30),
    DOMICILIO VARCHAR(30) NOT NULL,
    TELEFONO NUMBER(9) NOT NULL,
    EMAIL VARCHAR(30),
    COD_SUP NUMBER(4) NOT NULL,
    CONSTRAINT PK_VENDEDOR PRIMARY KEY(DNI),
    CONSTRAINT FK_SUP FOREIGN KEY(COD_SUP) REFERENCES SUPERMERCADO(COD_SUP) ON DELETE CASCADE
);

CREATE TABLE CLIENTE(
    DNI VARCHAR(9),
    NOMBRE VARCHAR(30) NOT NULL,
    PRAPELLIDO VARCHAR(30) NOT NULL,
    SGAPELLIDO VARCHAR(30),
    DOMICILIO VARCHAR(30) NOT NULL,
    TELEFONO NUMBER(9) NOT NULL,
    EMAIL VARCHAR(30),
    CONSTRAINT PK_CLIENTE PRIMARY KEY(DNI)
);

CREATE TABLE VENTA(
    COD_VENTA NUMBER(4),
    FECHA DATE,
    DNI_VEND VARCHAR(9),
    DNI_CLI VARCHAR(9),
    CONSTRAINT PK_VENTA PRIMARY KEY(COD_VENTA),
    CONSTRAINT FK_VENDEDOR FOREIGN KEY(DNI_VEND) REFERENCES VENDEDOR(DNI) ON DELETE CASCADE,
    CONSTRAINT FK_CLIENTE FOREIGN KEY(DNI_CLI) REFERENCES CLIENTE(DNI) ON DELETE CASCADE,
);

CREATE TABLE FAMILIA( -- PRODUCTO (Codificable)
    COD_FAMILIA NUMBER(4) CONSTRAINT PK_FAMILIA PRIMARY KEY
);

CREATE TABLE GENERO( -- PRODUCTO (Codificable)
    COD_GENERO NUMBER(4) CONSTRAINT PK_GENERO PRIMARY KEY
);

CREATE TABLE PRODUCTO(
    COD_PRODUCTO NUMBER(4),
    DESCRIPCION VARCHAR(30) NOT NULL,
    DESCUENTO NUMBER(4,2) DEFAULT 0,
    IVA NUMBER(2) NOT NULL,
    COD_FAMILIA NUMBER(4) NOT NULL, -- Codificable
    COD_GENERO NUMBER(4) NOT NULL, -- Codificable
    CONSTRAINT PK_PRODUCTO PRIMARY KEY(COD_PRODUCTO),
    CONSTRAINT FK_FAMILIA FOREIGN KEY(COD_FAMILIA) REFERENCES FAMILIA(COD_FAMILIA),
    CONSTRAINT FK_GENERO FOREIGN KEY(COD_GENERO) REFERENCES GENERO(COD_GENERO),
    CONSTRAINT CK_DESCUENTO CHECK(DESCUENTO > 0 AND DESCUENTO < 100), -- = (DESCUENTO BETWEEN 0 AND 100)
    CONSTRAINT CK_IVA CHECK(IVA IN (4, 10, 21))
);

CREATE TABLE LINEA_VENTA(
    NUM_LINEA NUMBER(4),
    COD_VENTA NUMBER(4),
    CANTIDAD NUMBER(4) NOT NULL,
    CONSTRAINT PK_LINEA_VENTA PRIMARY KEY(NUM_LINEA, COD_VENTA),
    CONSTRAINT FK_VENTA FOREIGN KEY(COD_VENTA) REFERENCES VENTA(COD_VENTA)
    CONSTRAINT CK_CANTIDAD CHECK(CANTIDAD BETWEEN 1 AND 249) -- BETWEEN incluye los extremos
);

CREATE TABLE DEVOLUCION(
    COD_VENTA NUMBER(4),
    NUM_LINEA NUMBER(4),
    FECHA DATE,
    ESTADO CHAR(1) NOT NULL,
    TIPO_DEV NUMBER(1) NOT NULL,
    CONSTRAINT PK_DEVOLUCION PRIMARY KEY(COD_VENTA, NUM_LINEA, FECHA),
    CONSTRAINT FK_LINEA_VENTA FOREIGN KEY(COD_VENTA, NUM_LINEA) REFERENCES LINEA_VENTA(COD_VENTA, NUM_LINEA)
    CONSTRAINT CK_ESTADO CHECK(ESTADO IN('B','M','F'))
    CONSTRAINT CK_TIPO_DEV CHECK(TIPO_DEV BETWEEN 1 AND 5)
);

CREATE TABLE PRECIO(
    COD_PROD NUMBER(4),
    FECHA DATE,
    PRECIO NUMBER(6,2) NOT NULL,
    CONSTRAINT PK_PRECIO PRIMARY KEY(COD_PROD, FECHA),
    CONSTRAINT FK_PRODUCTO FOREIGN KEY(COD_PROD) REFERENCES PRODUCTO(COD_PROD)
);