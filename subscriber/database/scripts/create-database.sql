CREATE TABLE IF NOT EXISTS cliente
(
    id_cliente SERIAL PRIMARY KEY,
    cedula_cliente character varying(10) NOT NULL,
    nombre_cliente character varying(25) NOT NULL
);

CREATE TABLE IF NOT EXISTS cocinero
(
    id_cocinero SERIAL PRIMARY KEY,
    cedula_cocinero character varying(10) NOT NULL,
    nombre_cocinero character varying(25) NOT NULL,
    especialidad character varying(25) NOT NULL
);

CREATE TABLE IF NOT EXISTS mesero
(
    id_mesero SERIAL PRIMARY KEY,
    nombre_mesero character varying(30) NOT NULL,
    cedula_mesero character varying(10) NOT NULL
);

CREATE TABLE IF NOT EXISTS pago
(
    id_pago SERIAL PRIMARY KEY,
    entidad_financiera character varying(50) NOT NULL,
    tipo_pago character varying(20) NOT NULL,
    confirmacion boolean NOT NULL,
    declinacion boolean NOT NULL
);

CREATE TABLE IF NOT EXISTS mesa
(
    id_mesa SERIAL PRIMARY KEY,
    numero_asientos bigint NOT NULL,
    mesero integer NOT NULL,
    CONSTRAINT mesero FOREIGN KEY (mesero)
        REFERENCES mesero (id_mesero) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);
