FROM golang as dependency
EXPOSE 8080
WORKDIR /go/src/app
COPY . .

FROM dependency

ARG SET_NODE_ENV
ENV NODE_ENV ${SET_NODE_ENV}

CMD go run main.go