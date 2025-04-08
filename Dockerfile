# Usa una imagen base de Odoo 17 v6my-gtwz-ykgi
FROM odoo:17

# Cambiar al usuario root para instalar dependencias
USER root

# Instalar dependencias del sistema
COPY ./requirements.txt /requirements.txt
RUN apt update && \
    apt install -y git && \
    pip3 install -r /requirements.txt && \
    rm /requirements.txt
