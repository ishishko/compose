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
docker compose build --no-cache

# Levantar los contenedores de Docker Compose
docker compose up -d

# Clonar los repositorios de Adhoc
git clone -b 17.0 --single-branch https://github.com/ingadhoc/odoo-argentina.git ./odoo-addons/ingadhoc/odoo-argentina 
git clone -b 17.0 --single-branch https://github.com/ingadhoc/account-payment.git ./odoo-addons/ingadhoc/account-payment 
git clone -b 17.0 --single-branch https://github.com/ingadhoc/account-invoicing.git ./odoo-addons/ingadhoc/account-invoicing 
git clone -b 17.0 --single-branch https://github.com/ingadhoc/argentina-sale.git ./odoo-addons/ingadhoc/argentina-sale 
git clone -b 17.0 --single-branch https://github.com/ingadhoc/miscellaneous.git ./odoo-addons/ingadhoc/miscellaneous 
git clone -b 17.0 --single-branch https://github.com/ingadhoc/stock.git ./odoo-addons/ingadhoc/stock 
git clone -b 17.0 --single-branch https://github.com/ingadhoc/account-financial-tools.git ./odoo-addons/ingadhoc/account-financial-tools 
git clone -b 17.0 --single-branch https://github.com/ingadhoc/odoo-argentina-ce.git ./odoo-addons/ingadhoc/odoo-argentina-ce

# Clonar repositorios de OCA
git clone -b 17.0 --single-branch https://github.com/OCA/account-financial-reporting.git ./odoo-addons/OCA/account-financial-reporting 
git clone -b 17.0 --single-branch https://github.com/OCA/account-reconcile.git ./odoo-addons/OCA/account-reconcile 
# Verificar que se migre el módulo web a la versión 17.0 17.0-mig-web_ir_actions_act_multi
# && git clone -b 17.0 --single-branch https://github.com/OCA/web.git ./odoo-addons/OCA/web 
git clone -b 17.0-mig-web_ir_actions_act_multi-v2 --single-branch https://github.com/adhoc-dev/web.git ./odoo-addons/OCA/web 
git clone -b 17.0 --single-branch https://github.com/OCA/server-tools.git ./odoo-addons/OCA/server-tools 
git clone -b 17.0 --single-branch https://github.com/OCA/server-ux.git ./odoo-addons/OCA/server-ux 
git clone -b 17.0 --single-branch https://github.com/OCA/stock-logistics-workflow.git ./odoo-addons/OCA/stock-logistics-workflow 
git clone -b 17.0 --single-branch https://github.com/OCA/sale-workflow.git ./odoo-addons/OCA/sale-workflow 
git clone -b 17.0 --single-branch https://github.com/OCA/reporting-engine.git ./odoo-addons/OCA/reporting-engine 
git clone -b 17.0 --single-branch https://github.com/OCA/project.git ./odoo-addons/OCA/project

# Agrega configuracion de Odoo
sudo cp -f odoo.conf odoo-etc/

# Asignando permisos a los archivos y carpetas
sudo chown -R $USER:$USER ./odoo-addons  ./odoo-data ./odoo-etc ./odoo-log
sudo chmod -R 775 ./odoo-addons ./odoo-data ./odoo-etc ./odoo-log

# Reiniciado servicios
docker compose down
docker compose up -d

# Verificar si Caddy está instalado
# if ! command -v caddy &> /dev/null
# then
#     echo "Instalando Caddy..."
#     sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https curl
#     curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
#     curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
#     sudo apt update
#     sudo apt install caddy
#     sudo cp -f Caddyfile /etc/caddy/
#     sudo systemctl restart caddy
#     echo "Caddy ya está instalado."
# else
#     echo "Caddy ya está instalado."
# fi

