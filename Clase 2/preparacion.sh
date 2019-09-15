#!/bin/bash

cd Labo\ 2_1
docker-compose up -d --build
cd ..

cd Labo\ 2_2
./init.sh
cd ..