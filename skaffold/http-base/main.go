package main

import (
	"bytes"
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
)

func main() {
	fmt.Println(os.Getenv("VERSION"))
	http.HandleFunc("/", func(writer http.ResponseWriter, request *http.Request) {
		writer.WriteHeader(500)
		writer.Write([]byte("error"))
	})

	http.HandleFunc("/123", func(writer http.ResponseWriter, request *http.Request) {
		b, _ := ioutil.ReadFile(".env")
		var buffer bytes.Buffer
		buffer.Write([]byte("hello istio"))
		buffer.Write(b)
	})
	http.ListenAndServe(":8080", nil)
}
