FROM golang:1.16.0-alpine3.12 AS go-builder
LABEL builder=true

RUN adduser -DH user

ENV CGO_ENABLED=0
ENV GO111MODULE=on
ENV WEBHOOK_VERSION=2.8.0

RUN apk add --update -t build-deps curl gcc git go libc-dev libgcc mercurial
RUN go get -a -ldflags '-s -w -extldflags "-static"' github.com/adnanh/webhook@${WEBHOOK_VERSION} \
    && /go/bin/webhook -version

FROM alpine:3.12
LABEL runtime=true

EXPOSE 9000
WORKDIR /app

RUN apk add --no-cache tini ca-certificates tzdata curl \
    && mkdir /etc/hooks

COPY --from=go-builder /go/bin/webhook /app/webhook
COPY --from=go-builder /etc/passwd /etc/passwd
USER user

ENTRYPOINT ["/sbin/tini", "--", "/app/webhook"]
CMD ["-port=9000", "-hooks=/etc/hooks/hooks.json", "-template", "-hotreload", "-verbose"]
COPY . /etc/hooks
