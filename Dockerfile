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
    apt-get install -y lsb-release && \
    apt-get install -y swig libssl-dev

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

# Clonar repositorios basicos
RUN git clone https://github.com/devman-dev/basic.git /mnt/extra-addons/source/basic \
    && git clone https://github.com/devman-dev/devman-addons.git /mnt/extra-addons/source/devman-addons

# Crear directorio para módulos de desarrollo
# RUN mkdir -p /mnt/extra-addons/source/devman-addons
# Agregando Path de modulos


# Copiando archivos para set de volumenes
RUN cp -r /mnt /mnt2 \
    && cp -r /usr/lib/python3/dist-packages/odoo/addons /usr/lib/python3/dist-packages/odoo/addons2 \
    && cp -r /var/lib/odoo /var/lib/odoo2

# Actualizar la configuración de OpenSSL para pyAfip
RUN sed -i 's/CipherString = DEFAULT:@SECLEVEL=2/CipherString = DEFAULT:@SECLEVEL=1/' /etc/ssl/openssl.cnf


# Copiar los requerimientos del módulo, si es que existen, e instalarlos
RUN find /mnt/extra-addons/ -name requirements.txt -exec pip install -r {} \;

# Dependencias auto_database_backup
RUN pip3 install dropbox \
    pyncclient \
    boto3 \
    nextcloud-api-wrapper \
    paramiko
# Correcion de dependencias
RUN pip uninstall -y chardet && \
    pip install chardet==3.0.4 && \
    pip uninstall -y httplib2 && \
    pip install httplib2==0.20.4 && \
    pip install --upgrade pip setuptools && \
    pip install M2Crypto
