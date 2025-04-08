#!/bin/bash

# Construye los contenedores definidos en el archivo docker-compose.yml sin utilizar la cache (--no-cache).
docker compose build 

# Levantar los contenedores de Docker Compose
docker compose up -d

# Asignando permisos a los archivos y carpetas
sudo chown -R $USER:$USER ./odoo-addons  ./odoo-data ./odoo-etc ./odoo-log
sudo chmod -R 775 ./odoo-addons ./odoo-data ./odoo-etc ./odoo-log

# Clonar los repositorios de Adhoc
git clone -b 16.0 --single-branch https://github.com/ingadhoc/odoo-argentina.git ./odoo-addons/ingadhoc/odoo-argentina 
git clone -b 16.0 --single-branch https://github.com/ingadhoc/account-payment.git ./odoo-addons/ingadhoc/account-payment 
git clone -b 16.0 --single-branch https://github.com/ingadhoc/account-invoicing.git ./odoo-addons/ingadhoc/account-invoicing 
git clone -b 16.0 --single-branch https://github.com/ingadhoc/argentina-sale.git ./odoo-addons/ingadhoc/argentina-sale 
git clone -b 16.0 --single-branch https://github.com/ingadhoc/miscellaneous.git ./odoo-addons/ingadhoc/miscellaneous 
git clone -b 16.0 --single-branch https://github.com/ingadhoc/stock.git ./odoo-addons/ingadhoc/stock 
git clone -b 16.0 --single-branch https://github.com/ingadhoc/account-financial-tools.git ./odoo-addons/ingadhoc/account-financial-tools 
git clone -b 16.0 --single-branch https://github.com/ingadhoc/odoo-argentina-ce.git ./odoo-addons/ingadhoc/odoo-argentina-ce

# Clonar repositorios de OCA
git clone -b 16.0 --single-branch https://github.com/OCA/account-financial-reporting.git ./odoo-addons/OCA/account-financial-reporting 
git clone -b 16.0 --single-branch https://github.com/OCA/account-reconcile.git ./odoo-addons/OCA/account-reconcile 
git clone -b 16.0 --single-branch https://github.com/OCA/web.git ./odoo-addons/OCA/web 
git clone -b 16.0 --single-branch https://github.com/OCA/server-tools.git ./odoo-addons/OCA/server-tools 
git clone -b 16.0 --single-branch https://github.com/OCA/server-ux.git ./odoo-addons/OCA/server-ux 
git clone -b 16.0 --single-branch https://github.com/OCA/stock-logistics-workflow.git ./odoo-addons/OCA/stock-logistics-workflow 
git clone -b 16.0 --single-branch https://github.com/OCA/sale-workflow.git ./odoo-addons/OCA/sale-workflow 
git clone -b 16.0 --single-branch https://github.com/OCA/reporting-engine.git ./odoo-addons/OCA/reporting-engine 
git clone -b 16.0 --single-branch https://github.com/OCA/project.git ./odoo-addons/OCA/project

git clone -b 16.0 --single-branch https://github.com/devman-dev/devman-addons.git ./odoo-addons/source/devman-addons
git clone -b main --single-branch https://github.com/devman-dev/basic.git ./odoo-addons/source/basic
# Agrega configuracion de Odoo
sudo cp -f odoo.conf odoo-etc/

# Asignando permisos a los archivos y carpetas
sudo chown -R $USER:$USER ./odoo-addons  ./odoo-data ./odoo-etc ./odoo-log
sudo chmod -R 775 ./odoo-addons ./odoo-data ./odoo-etc ./odoo-log


# Reiniciado servicios
docker compose down
docker compose up -d


