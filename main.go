package main

import (
	"errors"
	"fmt"
	"io"
	"log"
	"net/http"
	"os"
	"strconv"
)

func getHello(w http.ResponseWriter, r *http.Request) {
	fmt.Printf("got / request\n")
	io.WriteString(w, "Hello, World!\n")
}

func main() {
	http.HandleFunc("/", getHello)

	port := 3335
	portString := strconv.Itoa(port)

	log.Print("Listening on port " + portString + " ... ")
	err := http.ListenAndServe(":"+portString, nil)
	if errors.Is(err, http.ErrServerClosed) {
		fmt.Printf("server closed\n")
	} else if err != nil {
		fmt.Printf("error starting server: %s\n", err)
		os.Exit(1)
	}
}
