# step 1 build executable binary
# main container image as builder on goland
FROM golang:alpine as build-go

# add all files of the current directoty to the container directoty
ADD . /app

# install all the necessary packages for the operation of our go application
RUN cd /app && go build -o goapp .  

# step 2
# main for goland container from images alpine
FROM alpine

# sets the working directory
WORKDIR /app

# copy bin in container 
COPY --from=build-go /app/goapp /app/

# sets the port to access outside, i.e. example when deploying a container from the image "docker run -p 80:8082"
EXPOSE 80

# the command that will be executed when the container is expanded, the application start
ENTRYPOINT ["/app/goapp"]