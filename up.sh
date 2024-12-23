#!/bin/bash

# Construye los contenedores definidos en el archivo docker-compose.yml sin utilizar la cache (--no-cache).
 docker compose build --no-cache #| tee docker compose.log

# Levantar los contenedores de Docker Compose
docker compose up -d #| tee -a docker-compose.log

# Recupera archivos de volumenes y elimina directorio temporal
docker exec odoo17 cp -rf /mnt2/. /mnt
docker exec odoo17 rm -rf /mnt2 

# Agrega configuracion de Odoo
cp -rf ./base_odoo.conf ./etc/odoo.conf

# Reiniciado servicios
docker compose down
docker compose up
