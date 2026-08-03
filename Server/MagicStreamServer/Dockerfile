FROM golang:1.25.7 AS builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o main .


FROM gcr.io/distroless/static-debian12

WORKDIR /app

COPY --from=builder /app/main .

USER nonroot

EXPOSE 8080

CMD ["./main"]