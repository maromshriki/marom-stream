FROM golang:1.25.7 AS builder

WORKDIR /app

RUN apt-get update && \
    apt-get upgrade -y && \
    rm -rf /var/lib/apt/lists/*

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN go build -o main .

FROM gcr.io/distroless/static-debian12

WORKDIR /app

COPY --from=builder /app/main .

USER nonroot

EXPOSE 8080

CMD ["./main"]