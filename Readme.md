# Proyecto Docker Compose

## Introducción
Este proyecto utiliza Docker Compose para orquestar múltiples contenedores Docker. Proporciona un entorno de desarrollo reproducible y fácil de configurar.

## Requisitos previos
Antes de comenzar, asegúrate de tener instaladas las siguientes herramientas:
- [Docker](https://www.docker.com/get-started)

## Estructura del proyecto
La estructura del proyecto es la siguiente:
- `docker-compose.yml`: Archivo de configuración de Docker Compose que define los servicios, redes y volúmenes.
- `Dockerfile`: Archivo de configuración de Docker para construir la imagen de la aplicación.
- `up`: Archivo para contruccion de docker.
- `down`: Archivo para eliminacion completa de construccion de docker.
- `soft-up`: Archivo de construccion con uso de cache para imagenes ya creadas.
- `soft-down`: Archivo para detener e eliminar contenedores sin tocar imagenes.
   
- `README.md`: Este archivo de documentación.

## Instrucciones de uso

