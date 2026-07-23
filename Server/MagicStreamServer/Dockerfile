FROM golang:1.24.2 AS builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN go build -o main .

FROM debian:bookworm-slim

WORKDIR /app

COPY --from=builder /app/main .

RUN useradd -m appuser

USER appuser

EXPOSE 8080

CMD ["./main"]