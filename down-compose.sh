#!/bin/bash

# Detener todos los contenedores de Docker Compose
 docker compose stop

# Eliminar todos los contenedores de Docker Compose
 docker compose rm -f

# Eliminar todas las imágenes de Docker Compose
 docker image prune -a -f

# Eliminar todos los volúmenes de Docker Compose
 docker volume prune -f

# Eliminar las carpetas de los volumenes de Docker Compose
 rm -rf odoo-addons
 rm -rf odoo-data
 rm -rf postgres-data

# Eliminar todos los contenedores huérfanos de Docker Compose
 docker compose down --remove-orphans

# Eliminar todas las redes de Docker Compose
 docker network prune -f

# Verificar que no haya contenedores, imágenes, volúmenes o redes de Docker Compose
echo "Contenedores de Docker Compose"
 docker compose ps
echo "Imágenes de Docker Compose"
 docker image ls
echo "Volúmenes de Docker Compose"
 docker volume ls

