# Proyecto de Automatización con Docker y Caddy

## Introducción

El proyecto se encarga de automatizar la construcción utilizando Docker para levantar los servicios de Odoo y Caddy. Caddy se utiliza para la gestión de subdominios, manejo de certificados SSL (HTTPS) automático y proxies inversos. Los scripts están diseñados para servidores que corren bajo la distribución Ubuntu de Linux.

## Configuración de Odoo

Se ha agregado un archivo de configuración (`odoo.conf`) optimizado para los recursos de las VPS actuales:

- **CPU**: 4 cores
- **RAM**: 4GB
- **Almacenamiento**: 30GB

### Límites establecidos:

- Hasta 6 bases de datos diferentes
- Hasta 64 conexiones activas totales a las bases de datos
- Hasta 1 hora de inactividad por conexión
- Contraseña ADMIN de la base de datos establecida por defecto

## Configuración de Caddy

Se ha agregado un archivo de configuración (`Caddyfile`) donde se gestionan los subdominios. El archivo tiene la configuración básica habilitada. Se han creado dos scripts para agregar o eliminar subdominios en la VPS.

## Instalación de Odoo

Para manejar repositorios privados, se han agregado claves SSH (devman2DK) al repositorio. Sigue estos pasos para la instalación:

1. **Clonar el repositorio localmente**:
    ```bash
    git clone https://github.com/ishishko/compose.git
    ```

2. **Copiar las llaves de directorio devman2DK al ssh de la VPS**:
    ```bash
    scp -P puerto -r /ruta/local/de/la/carpeta/* usuario@vps:/ruta/remota/de/destino
    scp -r devman2DK/ usuario@vps:~/
    ```

3. **Ingresar a la VPS y agregar la clave SSH a la configuracion**:
    ```bash
    echo "Host *" > ~/.ssh/config
    echo "    IdentityFile ~/.ssh/id_rsa" >> ~/.ssh/config
    echo "    AddKeysToAgent yes" >> ~/.ssh/config
    ```

4. **Configurar el archivo archivo .bashrc**:
    ```bash
    echo "#Agregar claves SSH al agente" >> .bashrc
    echo "if [ -z "$SSH_AUTH_SOCK" ]; then" >> .bashrc
    echo '    eval "$(ssh-agent -s)"' >> .bashrc
    echo '    ssh-add ~/.ssh/llave1' >> .bashrc
    echo 'fi' >> .bashrc
    ```

5. **Recargar .bashrc**:
    ```bash
    source ~/.bashrc
    ```

6. **Descargar el repositorio en la VPS**:
    ```bash
    git clone git@github.com:ishishko/compose.git
    ```

7. **Iniciar los contenedores de Odoo**:
    ```bash
    sudo ./up.sh
    ```

## Proyecto Docker Compose y Caddy

### Introducción

Este proyecto utiliza Docker Compose para orquestar múltiples contenedores Docker y Caddy para gestionar subdominios y proxies inversos. Proporciona un entorno de desarrollo reproducible y fácil de configurar.

### Requisitos previos

El script `up.sh` se encargará de verificar e instalar las herramientas si es necesario:

- Docker
- Caddy

### Estructura del proyecto

La estructura del proyecto es la siguiente:

- `docker-compose.yml`: Archivo de configuración de Docker Compose que define los servicios, redes y volúmenes.
- `Dockerfile`: Archivo de configuración de Docker para construir la imagen de la aplicación.
- `up.sh`: Script para verificar e instalar herramientas necesarias, construir y levantar los contenedores de Docker Compose.
- `down.sh`: Script para detener y eliminar los contenedores, imágenes y volúmenes de Docker Compose.
- `AddSubdominio.sh`: Script para agregar un subdominio en Caddy.
- `DelSubdomnio.sh`: Script para eliminar un subdominio en Caddy.
- `Caddyfile`: Archivo de configuración de Caddy.
- `odoo.conf`: Archivo de configuración de Odoo.

### Funcionalidades

#### Docker Compose

- **Construcción y levantamiento de contenedores**: Utiliza el script `up.sh` para construir y levantar los contenedores definidos en el archivo `docker-compose.yml`.
- **Detención y eliminación de contenedores**: Utiliza el script `down.sh` para detener y eliminar los contenedores, imágenes y volúmenes asociados.
- **Configuración de Odoo**: El archivo `odoo.conf` contiene la configuración de Odoo utilizada por los contenedores.

#### Caddy

- **Gestión de subdominios**: Utiliza el script `AddSubdominio.sh` para agregar un nuevo subdominio y el script `DelSubdomnio.sh` para eliminar un subdominio existente.
- **Configuración de Caddy**: El archivo `Caddyfile` contiene la configuración de Caddy, incluyendo la configuración de subdominios y proxies inversos.

### Instrucciones de uso

#### Docker Compose

- **Construir y levantar los contenedores**:
    ```bash
    up.sh
    ```

- **Detener y eliminar los contenedores, imágenes y volúmenes**:
    ```bash
    down.sh
    ```

#### Caddy

- **Agregar un nuevo subdominio**:
    ```bash
    AddSubdominio.sh
    ```

- **Eliminar un subdominio existente**:
    ```bash
    DelSubdomnio.sh
    ```