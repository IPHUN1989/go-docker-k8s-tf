# Building
FROM golang:1.22-alpine AS build

WORKDIR /src

COPY ./main.go ./

RUN go mod init hello-world

RUN go build -o /src/hello

# Running
FROM scratch AS binary

COPY --from=build /src/hello /bin/hello

EXPOSE 3335

CMD ["/bin/hello"]
