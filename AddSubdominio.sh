#!/bin/bash

# Solicitar el nombre del nuevo subdominio
read -p "Introduce el nombre del nuevo subdominio: " subdominio

# Verificar si el archivo Caddyfile existe
CADDYFILE="/etc/caddy/Caddyfile"
if [ ! -f "$CADDYFILE" ]; then
    echo "El archivo Caddyfile no existe en /etc/caddy/"
    exit 1
fi

# Verificar si el subdominio ya existe en el archivo Caddyfile
if grep -q "$subdominio.devman2.com" "$CADDYFILE"; then
    echo "El subdominio $subdominio ya existe en el archivo Caddyfile."
    exit 1
fi

# Código a agregar con el subdominio reemplazado
codigo="
# Configuración del subdominio $subdominio
$subdominio.devman2.com {
    import common \"/var/log/caddy/ejemplo\"
    # Redirección de solicitudes a Odoo backend
    handle {
        reverse_proxy localhost:8069 {
            # Configuración de cabeceras para el proxy
            header_up Host {host}
            header_up X-Real-IP {remote_host}
            header_up X-Odoo-dbfilter $subdominio
        }
    }
    # Redirección de solicitudes websocket a OdooChat
    handle_path /websocket* {
        reverse_proxy localhost:8072 {
            header_up Host {host}
            header_up X-Real-IP {remote_host}
            header_up X-Forwarded-Proto {scheme}
            header_up Upgrade {>Upgrade}
            header_up Connection {>Connection}
            header_up X-Odoo-dbfilter $subdominio
        }
    }
}
# End of $subdominio

"

# Agregar el código al final del archivo Caddyfile
echo "$codigo" >> "$CADDYFILE"

echo "Reiniciando caddy.service"

sudo systemctl restart caddy.service

echo "Subdominio $subdominio agregado exitosamente al archivo Caddyfile."
