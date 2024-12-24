# Usa una imagen base de Odoo 17 v6my-gtwz-ykgi
FROM odoo:17

# Cambiar al usuario root para instalar dependencias
USER root

# Instalar dependencias del sistema
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y git && \
    apt-get install -y nano && \
    apt-get install -y python3-dev && \
    apt-get install -y gcc && \
    apt-get install -y libxml2-dev && \
    apt-get install -y libxslt1-dev && \
    apt-get install -y libldap2-dev && \
    apt-get install -y libsasl2-dev && \
    apt-get install -y libjpeg-dev && \
    apt-get install -y wget && \
    apt-get install -y gnupg2 && \
    apt-get install -y lsb-release

# Agrega la clave del repositorio de PostgreSQL
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    apt-get update && apt-get upgrade -y && \
    apt-get install -y postgresql-client libpq5 libpq-dev

# Limpia el caché de apt
RUN apt-get clean && rm -rf /var/lib/apt/lists/* && \
    apt-get update && apt-get install -y --fix-missing && \
    apt-get autoremove -y

# Clonar los repositorios de Adhoc
RUN git clone -b 17.0 --single-branch https://github.com/ingadhoc/odoo-argentina.git /mnt/extra-addons/ingadhoc/odoo-argentina \
    && git clone -b 17.0 --single-branch https://github.com/ingadhoc/account-payment.git /mnt/extra-addons/ingadhoc/account-payment \
    && git clone -b 17.0 --single-branch https://github.com/ingadhoc/account-invoicing.git /mnt/extra-addons/ingadhoc/account-invoicing \
    && git clone -b 17.0 --single-branch https://github.com/ingadhoc/argentina-sale.git /mnt/extra-addons/ingadhoc/argentina-sale \
    && git clone -b 17.0 --single-branch https://github.com/ingadhoc/miscellaneous.git /mnt/extra-addons/ingadhoc/miscellaneous \
    && git clone -b 17.0 --single-branch https://github.com/ingadhoc/stock.git /mnt/extra-addons/ingadhoc/stock \
    && git clone -b 17.0 --single-branch https://github.com/ingadhoc/account-financial-tools.git /mnt/extra-addons/ingadhoc/account-financial-tools \
    && git clone -b 17.0 --single-branch https://github.com/ingadhoc/odoo-argentina-ce.git /mnt/extra-addons/ingadhoc/odoo-argentina-ce
    
# Clonar repositorios de OCA
RUN git clone -b 17.0 --single-branch https://github.com/OCA/account-financial-reporting.git /mnt/extra-addons/OCA/account-financial-reporting \
    && git clone -b 17.0 --single-branch https://github.com/OCA/account-reconcile.git /mnt/extra-addons/OCA/account-reconcile \
    # Verificar que se migre el módulo web a la versión 17.0 17.0-mig-web_ir_actions_act_multi
    # && git clone -b 17.0 --single-branch https://github.com/OCA/web.git /mnt/extra-addons/OCA/web \
    && git clone -b 17.0-mig-web_ir_actions_act_multi-v2 --single-branch https://github.com/adhoc-dev/web.git /mnt/extra-addons/OCA/web \ 
    && git clone -b 17.0 --single-branch https://github.com/OCA/server-tools.git /mnt/extra-addons/OCA/server-tools \
    && git clone -b 17.0 --single-branch https://github.com/OCA/server-ux.git /mnt/extra-addons/OCA/server-ux \
    && git clone -b 17.0 --single-branch https://github.com/OCA/stock-logistics-workflow.git /mnt/extra-addons/OCA/stock-logistics-workflow \
    && git clone -b 17.0 --single-branch https://github.com/OCA/sale-workflow.git /mnt/extra-addons/OCA/sale-workflow \
    && git clone -b 17.0 --single-branch https://github.com/OCA/reporting-engine.git /mnt/extra-addons/OCA/reporting-engine \
    && git clone -b 17.0 --single-branch https://github.com/OCA/project.git /mnt/extra-addons/OCA/project

# Clonar repositorios de terceros
RUN git clone -b 17.0 --single-branch https://github.com/odoomates/odooapps.git /mnt/extra-addons/odoomates/odooapps

# Crear directorio para módulos de desarrollo
RUN mkdir -p /mnt/extra-addons/source/devman-addons
# Agregando Path de modulos
RUN sed -i 's|addons_path = /mnt/extra-addons|addons_path = /mnt/extra-addons/source,/mnt/extra-addons/source/devman-addons,/mnt/extra-addons/odoomates/odooapps,/mnt/extra-addons/ingadhoc/odoo-argentina,/mnt/extra-addons/ingadhoc/account-payment,/mnt/extra-addons/ingadhoc/account-invoicing,/mnt/extra-addons/ingadhoc/argentina-sale,/mnt/extra-addons/ingadhoc/miscellaneous,/mnt/extra-addons/ingadhoc/stock,/mnt/extra-addons/ingadhoc/account-financial-tools,/mnt/extra-addons/ingadhoc/odoo-argentina-ce,/mnt/extra-addons/OCA/account-financial-reporting,/mnt/extra-addons/OCA/account-reconcile,/mnt/extra-addons/OCA/web,/mnt/extra-addons/OCA/server-tools,/mnt/extra-addons/OCA/server-ux,/mnt/extra-addons/OCA/stock-logistics-workflow,/mnt/extra-addons/OCA/sale-workflow,/mnt/extra-addons/OCA/reporting-engine,/mnt/extra-addons/OCA/project|' /etc/odoo/odoo.conf

# Copiando archivos para set de volumenes
RUN cp -r /mnt /mnt2 \
    && cp -r /etc/odoo /etc/odoo2

# Dependencias auto_database_backup
RUN pip3 install dropbox \
    pyncclient \
    boto3 \
    nextcloud-api-wrapper \
    paramiko

# Actualizar la configuración de OpenSSL para pyAfip
RUN sed -i 's/CipherString = DEFAULT@SECLEVEL=2/CipherString = DEFAULT@SECLEVEL=1/' /etc/ssl/openssl.cnf


# Copiar los requerimientos del módulo, si es que existen, e instalarlos
RUN find /mnt/extra-addons/ -name requirements.txt -exec pip install -r {} \;

# Correcion de dependencias
RUN pip uninstall -y chardet && \
    pip install chardet==3.0.4
