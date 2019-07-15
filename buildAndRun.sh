#!/bin/bash

# build container
sudo docker build . -t golang:btest
# deploy container
sudo docker run -it --rm --name=btest -p 80:4444 golang:btest
