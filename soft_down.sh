#!/bin/bash

# Detener todos los contenedores de Docker Compose
 docker compose stop

# Eliminar todos los contenedores de Docker Compose
 docker compose rm -f

# Eliminar todos los contenedores huérfanos de Docker Compose
 docker compose down 

# Verificar que no haya contenedores, imágenes, volúmenes o redes de Docker Compose
echo "Contenedores de Docker Compose"
 docker compose ps
echo "Imágenes de Docker Compose"
 docker image ls
echo "Volúmenes de Docker Compose"
 docker volume ls

