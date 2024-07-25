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

func getHello(w http.ResponseWriter) {
	fmt.Printf("got / request\n")
	io.WriteString(w, "Hello, World!\n")
}

func getRealHello(w http.ResponseWriter, r *http.Request) {
	http.ServeFile(w, r, "./static/sites/hello.html")
}

func getError(w http.ResponseWriter, r *http.Request) {
	http.ServeFile(w, r, "./static/sites/error.html")
}

func main() {
	fs := http.FileServer(http.Dir("./static"))
	http.Handle("/static/", http.StripPrefix("/static/", fs))
	http.HandleFunc("/hidden", getRealHello)
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		if r.URL.Path != "/" && r.URL.Path != "/hidden" {
			w.WriteHeader(http.StatusNotFound)
			getError(w, r)
			return
		}
		getHello(w)
	})

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
