ALTER TABLE DIRECTOR ADD CONSTRAINT UK_DIRECTOR UNIQUE(TELEFONO, EMAIL);
ALTER TABLE VENDEDOR ADD CONSTRAINT UK_VENDEDOR UNIQUE(TELEFONO, EMAIL);
ALTER TABLE CLIENTE ADD CONSTRAINT UK_CLIENTE UNIQUE(TELEFONO, EMAIL);

ALTER TABLE DIRECTOR MODIFY TELEFONO NUMBER(9);
ALTER TABLE VENDEDOR MODIFY TELEFONO NUMBER(9);
ALTER TABLE CLIENTE MODIFY TELEFONO NUMBER(9);

ALTER TABLE VENTA ADD CONSTRAINT CK_DNIS CHECK(DNI_VEND != DNI_CLI);

ALTER TABLE PRODUCTO ADD CONSTRAINT UK_PRODUCTO UNIQUE(DESCRIPCION);
ALTER TABLE PRODUCTO MODIFY CONSTRAINT FK_FAMILIA FOREIGN KEY(COD_FAMILIA) REFERENCES FAMILIA(COD_FAMILIA) ON DELETE SET NULL;
ALTER TABLE PRODUCTO MODIFY CONSTRAINT FK_GENERO FOREIGN KEY(COD_GENERO) REFERENCES GENERO(COD_GENERO) ON DELETE SET NULL;

ALTER TABLE LINEA_VENTA ADD CONSTRAINT CK_NUM_LINEA CHECK(NUM_LINEA BETWEEN(1, 99));