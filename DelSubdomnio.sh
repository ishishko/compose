#!/bin/bash

# Solicitar el nombre del subdominio a eliminar
read -p "Introduce el nombre del subdominio a eliminar: " subdominio

# Verificar si el archivo Caddyfile existe
CADDYFILE="/etc/caddy/Caddyfile"
if [ ! -f "$CADDYFILE" ]; then
    echo "El archivo Caddyfile no existe en /etc/caddy/"
    exit 1
fi

# Verificar si el subdominio ya existe en el archivo Caddyfile
if ! grep -q "# Configuración del subdominio $subdominio" "$CADDYFILE"; then
    echo "El subdominio $subdominio no existe en el archivo Caddyfile."
    exit 1
fi

# Eliminar el bloque de configuración del subdominio
sed -i "/# Configuración del subdominio $subdominio/,/# End of $subdominio/d" "$CADDYFILE"

echo "Reiniciando caddy.service"

sudo systemctl restart caddy.service

echo "Subdominio $subdominio eliminado exitosamente del archivo Caddyfile."