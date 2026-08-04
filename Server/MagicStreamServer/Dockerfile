FROM golang:1.25.7 AS builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o main .


FROM gcr.io/distroless/static-debian12

WORKDIR /app

COPY --from=builder /app/main .

COPY --from=builder /app/Server/MagicStreamServer/certs/global-bundle.pem /app/certs/global-bundle.pem

USER nonroot

EXPOSE 8080

CMD ["./main"]