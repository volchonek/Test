package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
)

func runServer(port string) {
	mux := http.NewServeMux()

	mux.HandleFunc("/",
		func(w http.ResponseWriter, r *http.Request) {
			fmt.Fprintln(w, "port: ", port, "\nurl: ", r.URL.String())
		})

	mux.HandleFunc("/ping",
		func(w http.ResponseWriter, r *http.Request) {
			url := "192.168.11.80:8081/ping/?param=ping"
			resp, err := http.Get(url)
			if err != nil {
				printError(err)
				return
			}
			defer resp.Body.Close()

			respBody, err := ioutil.ReadAll(resp.Body)

			if err != nil {
				printError(err)
				return
			}

			fmt.Printf("http.Get body %#v\n\n\n", string(respBody))
		})

	server := http.Server{
		Addr:    port,
		Handler: mux,
	}

	fmt.Println("starting server at ", port)

	server.ListenAndServe()
}
