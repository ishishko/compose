# Usa una imagen base de Odoo 17 v6my-gtwz-ykgi
FROM odoo:16

# Cambiar al usuario root para instalar dependencias
USER root


COPY ./requirements.txt /requirements.txt
RUN apt update
RUN apt install -y git
RUN pip3 install -r /requirements.txt
RUN rm /requirements.txt
