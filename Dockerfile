# Copyright 2024 Google LLC
FROM golang:1.22.1 AS go-build

# The path of the Go code to build relative to the root
ARG BUILD_DIR

# Build app
WORKDIR /build
COPY . .
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main .

# Copy binary to distroless release
FROM gcr.io/distroless/static-debian12:latest AS release
ARG BUILD_DIR
COPY --from=go-build /build/main /main
CMD ["/main"]
