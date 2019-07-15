package main

import (
	"fmt"
	"os"
)

const (
	grpc = "grpc"
	rest = "rest"
)

func main() {
	fmt.Println("Container is run!!!")

	if os.Args[1] == grpc {
		//runGrpcServer() ?????
	}

	if os.Args[1] == rest {
		runHttpServer(":80")
	}
}
