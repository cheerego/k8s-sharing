FROM golang as dependency
EXPOSE 8080
WORKDIR /go/src/app
COPY . .

FROM dependency
CMD go run main.go