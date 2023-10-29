# Build stage
FROM golang:1.19-alpine AS builder
WORKDIR /app
COPY . .
RUN go build -o main main.go
RUN apk add curl
RUN curl -L https://github.com/golang-migrate/migrate/releases/download/v4.16.2/migrate.linux-amd64.tar.gz | tar xvz

# Run stage
FROM alpine
WORKDIR /app
COPY --from=builder /app/main .
COPY --from=builder /app/migrate ./migrate
COPY app.env .
COPY wait-for.sh .
COPY start.sh .
COPY db/migration ./migration

EXPOSE 5000
CMD [ "/app/main" ]
ENTRYPOINT ["/app/start.sh"]