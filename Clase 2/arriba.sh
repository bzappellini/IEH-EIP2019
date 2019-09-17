#!/bin/bash

echo "Entrando al labo 2.1"
cd Labo\ 2_1
echo toor | sudo chmod +x descargas.sh init.sh
./descargas.sh
./init.sh
echo "Saliendo..."
cd ..

echo "Entrando al labo 2.2"
cd Labo\ 2_2
echo toor | sudo chmod +x descargas.sh init.sh
./descargas.sh
echo "Saliendo..."
cd ..

echo "Fin!"