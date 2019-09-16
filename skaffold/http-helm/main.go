package main

import (
	"bytes"
	"io/ioutil"
	"net/http"
	"os"
)

func main() {
	http.HandleFunc("/", func(writer http.ResponseWriter, request *http.Request) {
		b, _ := ioutil.ReadFile(".env")
		var buffer bytes.Buffer
		buffer.Write([]byte("hello istio"))
		buffer.Write(b)
		buffer.Write([]byte(os.Getenv("ENV")))
		writer.Write(buffer.Bytes())
	})

	http.ListenAndServe(":8080", nil)
}
