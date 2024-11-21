#!/bin/bash

# Detener todos los contenedores de Docker Compose
sudo docker compose stop

# Eliminar todos los contenedores de Docker Compose
sudo docker compose rm -f

# Eliminar todas las imágenes de Docker Compose
sudo docker image prune -a -f

# Eliminar todos los volúmenes de Docker Compose
sudo docker volume prune -f

# Eliminar las carpetas de los volumenes de Docker Compose
sudo rm -rf odoo-addons
sudo rm -rf odoo-data
sudo rm -rf postgres-data

# Eliminar todos los contenedores huérfanos de Docker Compose
sudo docker compose down --remove-orphans

# Eliminar todas las redes de Docker Compose
sudo docker network prune -f

# Verificar que no haya contenedores, imágenes, volúmenes o redes de Docker Compose
echo "Contenedores de Docker Compose"
sudo docker compose ps
echo "Imágenes de Docker Compose"
sudo docker image ls
echo "Volúmenes de Docker Compose"
sudo docker volume ls

