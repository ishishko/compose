# Proyecto Docker Compose y Caddy

## Introducción
Este proyecto utiliza Docker Compose para orquestar múltiples contenedores Docker y Caddy para gestionar subdominios y proxies inversos. Proporciona un entorno de desarrollo reproducible y fácil de configurar.

## Requisitos previos
El script `up.sh` se encargará de verificar e instalar las herramientas si es necesario:
- [Docker](https://www.docker.com/get-started)
- [Caddy](https://caddyserver.com/)

## Estructura del proyecto
La estructura del proyecto es la siguiente:
- `docker-compose.yml`: Archivo de configuración de Docker Compose que define los servicios, redes y volúmenes.
- `Dockerfile`: Archivo de configuración de Docker para construir la imagen de la aplicación.
- `up.sh`: Script para construir y levantar los contenedores de Docker Compose.
- `down.sh`: Script para detener y eliminar los contenedores, imágenes y volúmenes de Docker Compose.
- `AddSubdominio.sh`: Script para agregar un subdominio en Caddy.
- `DelSubdomnio.sh`: Script para eliminar un subdominio en Caddy.
- `Caddyfile`: Archivo de configuración de Caddy.
- `odoo.conf`: Archivo de configuración de Odoo.
- `Readme.md`: Este archivo de documentación.

## Funcionalidades

### Docker Compose
- **Construcción y levantamiento de contenedores**: Utiliza el script [up.sh](compose/up.sh) para construir y levantar los contenedores definidos en el archivo [docker-compose.yml](compose/docker-compose.yml).
- **Detención y eliminación de contenedores**: Utiliza el script [down.sh](compose/down.sh) para detener y eliminar los contenedores, imágenes y volúmenes asociados.
- **Configuración de Odoo**: El archivo [odoo.conf](compose/odoo.conf) contiene la configuración de Odoo utilizada por los contenedores.

### Caddy
- **Gestión de subdominios**: Utiliza el script [AddSubdominio.sh](compose/AddSubdominio.sh) para agregar un nuevo subdominio y el script [DelSubdomnio.sh](compose/DelSubdomnio.sh) para eliminar un subdominio existente.
- **Configuración de Caddy**: El archivo [Caddyfile](compose/Caddyfile) contiene la configuración de Caddy, incluyendo la configuración de subdominios y proxies inversos.

## Instrucciones de uso

### Docker Compose
1. Construir y levantar los contenedores:
    ```sh
    ./compose/up.sh
    ```
2. Detener y eliminar los contenedores, imágenes y volúmenes:
    ```sh
    ./compose/down.sh
    ```

### Caddy
1. Agregar un nuevo subdominio:
    ```sh
    ./compose/AddSubdominio.sh
    ```
2. Eliminar un subdominio existente:
    ```sh
    ./compose/DelSubdomnio.sh
    ```

## Contribuciones
Si deseas contribuir a este proyecto, por favor abre un issue o envía un pull request en el repositorio.

## Licencia
Este proyecto está licenciado bajo la Licencia MIT. Consulta el archivo LICENSE para más detalles.