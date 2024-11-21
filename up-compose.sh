#!/bin/bash

# Construye los contenedores definidos en el archivo docker-compose.yml sin utilizar la cache (--no-cache).
 docker compose build --no-cache #| tee docker compose.log
 docker compose up #| tee -a docker-compose.log