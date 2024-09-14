FROM golang:1.22.3-bookworm AS build

WORKDIR /app

COPY go.mod ./
COPY go.sum ./

RUN go mod download && go mod verify

COPY . .

RUN go build -o /myapp .

FROM gcr.io/distroless/base-debian12

ARG VERSION
ENV VERSION=$VERSION
ARG COLOR
ENV COLOR=$COLOR

COPY --from=build /myapp /myapp

ENTRYPOINT ["/myapp"]
