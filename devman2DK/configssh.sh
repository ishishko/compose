#!/bin/bash

# Agregar configuracion ssh
echo "Configurando SSH..."
echo "Host *" > ~/.ssh/config
echo "    IdentityFile ~/compose/devman2DK/compose.pub" >> ~/.ssh/config
echo "    IdentityFile ~/compose/devman2DK/devman-addons.pub" >> ~/.ssh/config
echo "    AddKeysToAgent yes" >> ~/.ssh/config
echo "Configuración SSH terminada."

# Automatizar carga de llaves
echo "Configurando carga de llaves SSH..."
echo "#Agregar claves SSH al agente" >> .bashrc
echo "if [ -z "$SSH_AUTH_SOCK" ]; then" >> .bashrc
echo '    eval "$(ssh-agent -s)"' >> .bashrc
echo '    ssh-add ~/compose/devman2DK/compose.pub' >> .bashrc
echo '    ssh-add ~/compose/devman2DK/devman-addons.pub' >> .bashrc
echo 'fi' >> .bashrc
echo "Configuración de carga de llaves SSH terminada."