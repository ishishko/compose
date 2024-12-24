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

# Agrega configuracion de Odoo
sudo cp -f odoo.conf etc/

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

