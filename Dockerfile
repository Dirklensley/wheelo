FROM golang:1.13 as build_base

WORKDIR /box

COPY go.mod .
COPY go.sum .

RUN go mod download

FROM build_base as builder

COPY main.go .
COPY controllers ./controllers

RUN CGO_ENABLED="0" go build

FROM alpine:latest

COPY --from=builder /box/wheelo .
COPY assets assets
COPY views views

EXPOSE 8080

ENTRYPOINT [ "./wheelo" ]
