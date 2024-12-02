#!/bin/bash

# Construye los contenedores definidos en el archivo docker-compose.yml sin utilizar la cache (--no-cache).
 docker compose build --no-cache #| tee docker compose.log
 docker compose up #| tee -a docker-compose.log

# Clonar los repositorios de Adhoc
git clone -b 17.0 --single-branch https://github.com/ingadhoc/odoo-argentina.git ~/Desktop/odoo-addons/ingadhoc/odoo-argentina \
    && git clone -b 17.0 --single-branch https://github.com/ingadhoc/account-payment.git ~/Desktop/odoo-addons/ingadhoc/account-payment \
    && git clone -b 17.0 --single-branch https://github.com/ingadhoc/account-invoicing.git ~/Desktop/odoo-addons/ingadhoc/account-invoicing \
    && git clone -b 17.0 --single-branch https://github.com/ingadhoc/argentina-sale.git ~/Desktop/odoo-addons/ingadhoc/argentina-sale \
    && git clone -b 17.0 --single-branch https://github.com/ingadhoc/miscellaneous.git ~/Desktop/odoo-addons/ingadhoc/miscellaneous \
    && git clone -b 17.0 --single-branch https://github.com/ingadhoc/stock.git ~/Desktop/odoo-addons/ingadhoc/stock \
    && git clone -b 17.0 --single-branch https://github.com/ingadhoc/account-financial-tools.git ~/Desktop/odoo-addons/ingadhoc/account-financial-tools \
    && git clone -b 17.0 --single-branch https://github.com/ingadhoc/odoo-argentina-ce.git ~/Desktop/odoo-addons/ingadhoc/odoo-argentina-ce

# Clonar repositorios de OCA
git clone -b 17.0 --single-branch https://github.com/OCA/account-financial-reporting.git ~/Desktop/odoo-addons/OCA/account-financial-reporting \
    && git clone -b 17.0 --single-branch https://github.com/OCA/account-reconcile.git ~/Desktop/odoo-addons/OCA/account-reconcile \
    # Verificar que se migre el módulo web a la versión 17.0 17.0-mig-web_ir_actions_act_multi
    # && git clone -b 17.0 --single-branch https://github.com/OCA/web.git ~/Desktop/odoo-addons/OCA/web \
    && git clone -b 17.0-mig-web_ir_actions_act_multi-v2 --single-branch https://github.com/adhoc-dev/web.git ~/Desktop/odoo-addons/OCA/web \
    && git clone -b 17.0 --single-branch https://github.com/OCA/server-tools.git ~/Desktop/odoo-addons/OCA/server-tools \
    && git clone -b 17.0 --single-branch https://github.com/OCA/server-ux.git ~/Desktop/odoo-addons/OCA/server-ux \
    && git clone -b 17.0 --single-branch https://github.com/OCA/stock-logistics-workflow.git ~/Desktop/odoo-addons/OCA/stock-logistics-workflow \
    && git clone -b 17.0 --single-branch https://github.com/OCA/sale-workflow.git ~/Desktop/odoo-addons/OCA/sale-workflow \
    && git clone -b 17.0 --single-branch https://github.com/OCA/reporting-engine.git ~/Desktop/odoo-addons/OCA/reporting-engine