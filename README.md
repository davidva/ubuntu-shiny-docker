INSTALL DOCKER
==============

brew install docker docker-machine docker-compose caskroom/cask/brew-cask brew cask install virtualbox

docker-machine create --driver virtualbox dev eval "$(docker-machine env dev)"

docker build -t davidva/example-shiny-app .

BUILD THE IMAGE
===============

docker-machine create --driver virtualbox dev

eval "$(docker-machine env dev)"

docker build -t davidva/example-shiny-app .

RUN IT
======

docker run -rm -p 80:80 davidva/example-shiny-app

docker exec -it <TAG> /bin/bash

docker-machine ip dev
