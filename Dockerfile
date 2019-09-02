FROM golang:1.12 as builder
WORKDIR /work/
COPY main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /work/
COPY --from=builder /work/app .
CMD ["./app"]