#!/bin/bash

# Verificar si Docker está instalado
if ! command -v docker &> /dev/null
then
    echo "Instalando Docker..."
    sudo apt update
    sudo apt install -y snapd
    sudo snap install docker
    echo "Docker ya está instalado."
else
    echo "Docker ya está instalado."
fi

# Construye los contenedores definidos en el archivo docker-compose.yml sin utilizar la cache (--no-cache).
docker compose build --no-cache #| tee docker compose.log

# Levantar los contenedores de Docker Compose
docker compose up -d #| tee -a docker-compose.log

# Recupera archivos de volumenes y elimina directorio temporal
docker exec odoo17 cp -rf /mnt2/. /mnt
docker exec odoo17 rm -rf /mnt2 
docker exec odoo17 cp -rf /usr/lib/python3/dist-packages/odoo/addons2/. /usr/lib/python3/dist-packages/odoo/addons
docker exec odoo17 rm -rf /usr/lib/python3/dist-packages/odoo/addons2
docker exec odoo17 cp -rf /var/lib/odoo2/. /var/lib/odoo
docker exec odoo17 rm -rf /var/lib/odoo2

# Agrega configuracion de Odoo
sudo cp -f odoo.conf odoo-etc/

# Asignando permisos a los archivos y carpetas
sudo chown -R $USER:$USER ./odoo-addons ./odoo-backups ./odoo-base ./odoo-data ./odoo-etc ./odoo-log ./postgres-data
sudo chmod -R 775 ./odoo-addons ./odoo-backups ./odoo-base ./odoo-data ./odoo-etc ./odoo-log ./postgres-data

# Reiniciado servicios
docker compose down
docker compose up -d

# Verificar si Caddy está instalado
if ! command -v caddy &> /dev/null
then
    echo "Instalando Caddy..."
    sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https curl
    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
    sudo apt update
    sudo apt install caddy
    sudo cp -f Caddyfile /etc/caddy/
    sudo systemctl restart caddy
    echo "Caddy ya está instalado."
else
    echo "Caddy ya está instalado."
fi

