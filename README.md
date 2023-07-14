# Configuración de Replicación con pglogical

Este repositorio contiene instrucciones y scripts para configurar la replicación utilizando pglogical en PostgreSQL.

## Requisitos

- Docker
- Docker Compose

## Pasos de Configuración

### Paso 1: Configuración en el nodo Master1

1. Abrir el archivo `postgresql.conf` en el nodo Master1.
2. Buscar y modificar los siguientes parámetros:

listen_addresses = '*'
wal_level = 'logical'
max_worker_processes = 20
max_wal_senders = 20
max_replication_slots = 20
shared_preload_libraries = 'pglogical'

3. Guardar los cambios y reiniciar el servidor PostgreSQL.

4. Cambiar el nombre de la base de datos en el archivo `.env` del nodo Master1.

### Paso 2: Iniciar los contenedores

Ejecutar el siguiente comando para iniciar los contenedores:

Aquí tienes el contenido completo para un archivo README:

markdown
Copy code
# Configuración de Replicación con pglogical

Este repositorio contiene instrucciones y scripts para configurar la replicación utilizando pglogical en PostgreSQL.

## Requisitos

- Docker
- Docker Compose

## Pasos de Configuración

### Paso 1: Configuración en el nodo Master1

1. Abrir el archivo `postgresql.conf` en el nodo Master1.
2. Buscar y modificar los siguientes parámetros:
listen_addresses = '*'
wal_level = 'logical'
max_worker_processes = 20
max_wal_senders = 20
max_replication_slots = 20
shared_preload_libraries = 'pglogical'

markdown
Copy code
3. Guardar los cambios y reiniciar el servidor PostgreSQL.

4. Cambiar el nombre de la base de datos en el archivo `.env` del nodo Master1.

### Paso 2: Iniciar los contenedores

Ejecutar el siguiente comando para iniciar los contenedores:

docker-compose up


### Paso 3: Configuración en pgadmin (nodo Master1)

1. Abrir pgAdmin.
2. Crear una nueva conexión con los siguientes detalles:

Name: Master1
Host: localhost
Port: 5489
Maintenance database: restaurante
Username: provider
Password: provider

3. Guardar la conexión.

### Paso 4: Scripts para creación de la base de datos y tablas (nodo Master1)

Ejecutar los scripts necesarios para crear la base de datos y las tablas en el nodo Master1.

### Paso 5: Scripts del provider-node (nodo Master1)

Ejecutar los siguientes scripts en el nodo Master1:


CREATE EXTENSION IF NOT EXISTS pglogical;

-- Crear un nodo proveedor
SELECT pglogical.create_node(
node_name := 'provider-node',
dsn := 'host=provider-db port=5432 dbname=restaurante user=provider password=provider'
);

-- Agregar todas las tablas del esquema "public" al conjunto de replicación predeterminado.
SELECT pglogical.replication_set_add_all_tables(
set_name := 'default',
schema_names := ARRAY['public'],
synchronize_data := true
);


### Paso 6: Configuración en el nodo Subscriber

1. Cambiar el nombre de la base de datos en el archivo `.env` del nodo Subscriber.

### Paso 7: Iniciar los contenedores (nodo Subscriber)

Ejecutar el siguiente comando para iniciar los contenedores en el nodo Subscriber:

docker-compose up



### Paso 8: Configuración en pgadmin (nodo Subscriber)

1. Abrir pgAdmin.
2. Crear una nueva conexión con los siguientes detalles:

Name: Subscriber
Host: localhost
Port: 5440
Maintenance database: restaurante
Username: subscriber
Password: subscriber

3. Guardar la conexión.

### Paso 9: Scripts para creación de la base de datos y tablas (nodo Subscriber)

Ejecutar los scripts necesarios para crear la base de datos y las tablas en el nodo Subscriber.

### Paso 10: Scripts del subscriber-node (nodo Subscriber)

Ejecutar los siguientes scripts en el nodo Subscriber:

Name: Subscriber
Host: localhost
Port: 5440
Maintenance database: restaurante
Username: subscriber
Password: subscriber

3. Guardar la conexión.

### Paso 9: Scripts para creación de la base de datos y tablas (nodo Subscriber)

Ejecutar los scripts necesarios para crear la base de datos y las tablas en el nodo Subscriber.

### Paso 10: Scripts del subscriber-node (nodo Subscriber)

Ejecutar los siguientes scripts en el nodo Subscriber:

-- Verificar las extensiones instaladas
SELECT * FROM pg_extension;

-- Instalar la extensión pglogical
CREATE EXTENSION IF NOT EXISTS pglogical;

-- Crear un nodo suscriptor
SELECT pglogical.create_node(
node_name := 'subscriber-node',
dsn := 'host=subscriber-db port=5432 dbname=restaurante user=subscriber password=subscriber'
);

-- Crear una suscripción
SELECT pglogical.create_subscription(
subscription_name := 'subscription',
provider_dsn := 'host=192.168.39.138 port=5489 dbname=restaurante user=provider password=provider'
);


### Paso 11: Configuración adicional en el nodo Master1

Ejecutar el siguiente script en el nodo Master1:



### Paso 11: Configuración adicional en el nodo Master1

Ejecutar el siguiente script en el nodo Master1:

SELECT pglogical.create_subscription(
subscription_name := 'subscription_subscriber',
provider_dsn := 'host=192.168.39.161 port=5440 dbname=restaurante user=subscriber password=subscriber'
);

### Paso 12: Configuración adicional en el nodo Subscriber

Ejecutar el siguiente script en el nodo Subscriber:
SELECT pglogical.replication_set_add_all_tables(
set_name := 'default',
schema_names := ARRAY['public'],
synchronize_data := true
);

¡La configuración de replicación debería estar completa!




Made with ❤️ by @davidcasr
