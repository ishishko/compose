#!/bin/bash

# Construye los contenedores definidos en el archivo docker-compose.yml sin utilizar la cache (--no-cache).
 docker compose build --no-cache #| tee docker compose.log

# Clonar los repositorios de Adhoc
git clone -b 17.0 --single-branch https://github.com/ingadhoc/odoo-argentina.git ./odoo-addons/ingadhoc/odoo-argentina \
    && git clone -b 17.0 --single-branch https://github.com/ingadhoc/account-payment.git ./odoo-addons/ingadhoc/account-payment \
    && git clone -b 17.0 --single-branch https://github.com/ingadhoc/account-invoicing.git ./odoo-addons/ingadhoc/account-invoicing \
    && git clone -b 17.0 --single-branch https://github.com/ingadhoc/argentina-sale.git ./odoo-addons/ingadhoc/argentina-sale \
    && git clone -b 17.0 --single-branch https://github.com/ingadhoc/miscellaneous.git ./odoo-addons/ingadhoc/miscellaneous \
    && git clone -b 17.0 --single-branch https://github.com/ingadhoc/stock.git ./odoo-addons/ingadhoc/stock \
    && git clone -b 17.0 --single-branch https://github.com/ingadhoc/account-financial-tools.git ./odoo-addons/ingadhoc/account-financial-tools \
    && git clone -b 17.0 --single-branch https://github.com/ingadhoc/odoo-argentina-ce.git ./odoo-addons/ingadhoc/odoo-argentina-ce

# Clonar repositorios de OCA
git clone -b 17.0 --single-branch https://github.com/OCA/account-financial-reporting.git ./odoo-addons/OCA/account-financial-reporting \
    && git clone -b 17.0 --single-branch https://github.com/OCA/account-reconcile.git ./odoo-addons/OCA/account-reconcile \
    && git clone -b 17.0-mig-web_ir_actions_act_multi-v2 --single-branch https://github.com/adhoc-dev/web.git ./odoo-addons/OCA/web \
    && git clone -b 17.0 --single-branch https://github.com/OCA/server-tools.git ./odoo-addons/OCA/server-tools \
    && git clone -b 17.0 --single-branch https://github.com/OCA/server-ux.git ./odoo-addons/OCA/server-ux \
    && git clone -b 17.0 --single-branch https://github.com/OCA/stock-logistics-workflow.git ./odoo-addons/OCA/stock-logistics-workflow \
    && git clone -b 17.0 --single-branch https://github.com/OCA/sale-workflow.git ./odoo-addons/OCA/sale-workflow \
    && git clone -b 17.0 --single-branch https://github.com/OCA/reporting-engine.git ./odoo-addons/OCA/reporting-engine

# Clonar repositorios de terceros
mkdir -p ./odoo-addons/source
git clone -b 17.0 --single-branch git@github.com:devman-dev/devman-addons.git ./odoo-addons/source/devman-addons

# Levantar los contenedores de Docker Compose
docker compose up #| tee -a docker-compose.log