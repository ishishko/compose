# Usa una imagen base de Odoo 17 v6my-gtwz-ykgi
FROM odoo:17

# Cambiar al usuario root para instalar dependencias
USER root

# Instalar dependencias del sistema
RUN apt-get update && apt-get upgrade -y && apt-get install -y
RUN apt-get install -y git
RUN apt-get install -y nano
RUN apt-get install -y python3-dev
RUN apt-get install -y gcc
RUN apt-get install -y libxml2-dev
RUN apt-get install -y libxslt1-dev
RUN apt-get install -y libldap2-dev
RUN apt-get install -y libsasl2-dev
RUN apt-get install -y libjpeg-dev
RUN apt-get update && apt-get install -y wget gnupg2 lsb-release

# Agrega la clave del repositorio de PostgreSQL
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN apt-get update && apt-get upgrade -y && apt-get install -y
RUN apt-get install -y postgresql-client
RUN apt-get install -y libpq5 libpq-dev

# Limpia el caché de apt
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y --fix-missing
RUN apt-get autoremove -y

# Agregando repositorios de localizacion argentina y modulos propios
RUN chmod 777 /mnt/extra-addons
RUN git clone https://github.com/ishishko/ingadhoc.git /mnt/extra-addons/ingadhoc
RUN git clone https://github.com/ishishko/OCA.git /mnt/extra-addons/OCA
RUN mkdir -p /mnt/extra-addons/source

# Establecer la variable de entorno para addons_path
# ENV ODOO_ADDONS_PATH="/mnt/extra-addons/loc_arg/ingadhoc/account-payment,/mnt/extra-addons/loc_arg/ingadhoc/account-invoicing,/mnt/extra-addons/loc_arg/ingadhoc/argentina-sale,/mnt/extra-addons/loc_arg/ingadhoc/miscellaneous,/mnt/extra-addons/loc_arg/ingadhoc/stock,/mnt/extra-addons/loc_arg/ingadhoc/account-financial-tools,/mnt/extra-addons/loc_arg/OCA/account-financial-reporting,/mnt/extra-addons/loc_arg/OCA/account-reconcile,/mnt/extra-addons/loc_arg/OCA/web,/mnt/extra-addons/loc_arg/OCA/server-tools,/mnt/extra-addons/loc_arg/OCA/stock-logistics-workflow,/mnt/extra-addons/loc_arg/OCA/sale-workflow"

# Actualizar la configuración de OpenSSL para pyAfip
RUN sed -i 's/CipherString = DEFAULT@SECLEVEL=2/CipherString = DEFAULT@SECLEVEL=1/' /etc/ssl/openssl.cnf

RUN sed -i 's|addons_path = /mnt/extra-addons|addons_path = /mnt/extra-addons/source,/mnt/extra-addons/ingadhoc/account-payment,/mnt/extra-addons/ingadhoc/account-invoicing,/mnt/extra-addons/ingadhoc/argentina-sale,/mnt/extra-addons/ingadhoc/miscellaneous,/mnt/extra-addons/ingadhoc/stock,/mnt/extra-addons/ingadhoc/account-financial-tools,/mnt/extra-addons/OCA/account-financial-reporting,/mnt/extra-addons/OCA/account-reconcile,/mnt/extra-addons/OCA/web,/mnt/extra-addons/OCA/server-tools,/mnt/extra-addons/OCA/stock-logistics-workflow,/mnt/extra-addons/OCA/sale-workflow|' /etc/odoo/odoo.conf

# Copiar los requerimientos del módulo, si es que existen, e instalarlos
# Instalar dependencias de los módulos
RUN find /mnt/extra-addons/ -name requirements.txt -exec pip install -r {} \;

