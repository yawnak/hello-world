# build goapp image
FROM golang:1.21 AS goapp

RUN mkdir /app
WORKDIR /app

#Download dependencies
COPY go.mod go.sum ./
RUN go mod download
RUN go mod verify

COPY cmd ./cmd

RUN CGO_ENABLED=0 GOOS=linux go build -o /build ./cmd/hello_world

# use distroless to make smaller image
FROM gcr.io/distroless/base-debian11

WORKDIR /app

#copy application binary
COPY --from=goapp /build /build

EXPOSE 3000

USER nonroot:nonroot

ENTRYPOINT [ "/build" ]