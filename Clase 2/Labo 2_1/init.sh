#!/bin/bash

# Levantar el servidor
if [ "$#" -gt "0" ] && [ "$1" == "build" ]; then
    docker-compose up -d --build
else 
    docker-compose up -d
fi

# Obtener la ip del contenedor
IP_ADDR=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' labo2_1)

# Configurar las URLS
grep -qxF $IP_ADDR' www.sitio1.com' /etc/hosts || sudo echo $IP_ADDR' www.sitio1.com' >> /etc/hosts
grep -qxF $IP_ADDR' www.sitio2.com' /etc/hosts || sudo echo $IP_ADDR' www.sitio2.com' >> /etc/hosts
grep -qxF $IP_ADDR' www.nuevo.com' /etc/hosts || sudo echo $IP_ADDR' www.nuevo.com' >> /etc/hosts
