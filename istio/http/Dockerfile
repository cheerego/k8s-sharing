FROM golang as dependency
EXPOSE 8080
RUN apt-get update && apt-get install -y vim
WORKDIR /go/src/app
COPY . .

FROM dependency
CMD go run main.go