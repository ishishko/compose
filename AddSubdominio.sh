#!/bin/bash

# Solicitar el nombre del nuevo subdominio
read -p "Introduce el nombre del nuevo subdominio: " subdominio

# Verificar si el archivo Caddyfile existe
CADDYFILE="/etc/caddy/Caddyfile"
if [ ! -f "$CADDYFILE" ]; then
    echo "El archivo Caddyfile no existe en /etc/caddy/"
    exit 1
fi

# Código a agregar con el subdominio reemplazado
codigo="
$subdominio.devman2.com {
    import common \"/var/log/caddy/$subdominio\"
    reverse_proxy localhost:8069 {
        # Configuración de cabeceras para el proxy
        header_up Host {host}
        header_up X-Real-IP {remote_host}
        header_up X-Odoo-dbfilter $subdominio
    }
}
"

# Agregar el código al final del archivo Caddyfile
echo "$codigo" >> "$CADDYFILE"

sudo systemctl restart caddy.service

echo "Subdominio $subdominio agregado exitosamente al archivo Caddyfile."