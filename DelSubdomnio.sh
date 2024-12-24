#!/bin/bash

# Solicitar el nombre del subdominio a eliminar
read -p "Introduce el nombre del subdominio a eliminar: " subdominio

# Verificar si el archivo Caddyfile existe
CADDYFILE="/etc/caddy/Caddyfile"
if [ ! -f "$CADDYFILE" ]; then
    echo "El archivo Caddyfile no existe en /etc/caddy/"
    exit 1
fi

# Eliminar el bloque que contiene el subdominio
sed -i "/$subdominio.devman2.com {/,/}/d" "$CADDYFILE"

sudo systemctl restart caddy.service

echo "Subdominio $subdominio eliminado exitosamente del archivo Caddyfile."