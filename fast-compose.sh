#!/bin/bash

# Construye los contenedores definidos en el archivo docker-compose.yml sin utilizar la cache (--no-cache).
sudo docker compose build #| tee docker compose.log
sudo docker compose up #| tee -a docker-compose.log