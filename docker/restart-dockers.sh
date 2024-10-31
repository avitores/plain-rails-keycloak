#!/bin/bash


echo "PARANDO DOCKERS docker stop $(docker-compose ps $1)"
docker stop $(docker-compose ps -a -q $1)

echo "ELIMINANDO DOCKERS docker rm $(docker-compose ps -a $1 | grep Exit | cut -d ' ' -f 1)"
docker rm $(docker-compose ps -a $1 | grep Exit | cut -d ' ' -f 1)

echo "ELIMINANDO IMAGENES DE DOCKERS docker rmi $(docker-compose images | tail -n +2 | awk '$1 == "<none>" {print $'3'}')"
docker rmi $(docker-compose images | tail -n +2 | awk '$1 == "<none>" {print $'3'}')

echo "ELIMINANDO VOLUMENES HUÉRFANOS"
docker volume rm $(docker volume ls -qf dangling=true)

echo "LEVANTANDO DOCKER $1"
docker-compose up -d $1

docker-compose ps

docker-compose logs $1
