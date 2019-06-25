# step 1 build executable binary
# main container image as builder on goland
FROM golang:alpine as build-go

# add all files of the current directoty to the container directoty
ADD . /go/src

# install all the necessary packages for the operation of our go application
RUN apk update git &&\
    apk add git &&\
    go get github.com/pkg/errors &&\
    go build -o btest ./src  

# step 2
# main for goland container from images alpine
FROM alpine

# sets the working directory
WORKDIR /app

# copy bin in container 
COPY --from=build-go /go/src /app/

# sets the port to access outside, i.e. example when deploying a container from the image "docker run -p xxxx: 4444 demo"
EXPOSE 4444

# the command that will be executed when the container is expanded, the application start
ENTRYPOINT ["/app"]

