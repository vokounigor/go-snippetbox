FROM golang:1.20 AS build-stage
WORKDIR /app
COPY . ./
RUN go mod download
RUN cd ./cmd/web && CGO_ENABLED=0 GOOS=linux go build -o /snippetbox

FROM gcr.io/distroless/base-debian11 AS build-release-stage
WORKDIR /
COPY --from=build-stage /snippetbox /snippetbox
COPY .env /
COPY tls /tls
COPY migrations /migrations
COPY ui /ui
