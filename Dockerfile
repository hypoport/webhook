FROM golang:alpine3.10 AS go-builder
LABEL builder=true

RUN adduser -DH user

ENV CGO_ENABLED=0
ENV GO111MODULE=on
ENV WEBHOOK_VERSION=2.6.11

RUN apk add --update -t build-deps curl gcc git go libc-dev libgcc mercurial
RUN go get -a -ldflags '-s -w -extldflags "-static"' github.com/adnanh/webhook@${WEBHOOK_VERSION} \
    /go/bin/webhook -version

FROM alpine:3.10
LABEL runtime=true

EXPOSE 9000
WORKDIR /app

RUN apk add --no-cache ca-certificates curl \
    && mkdir /etc/hooks

COPY --from=go-builder /go/bin/webhook /app/webhook
COPY --from=go-builder /etc/passwd /etc/passwd
USER user

CMD [ "/app/webhook", "-port=9000", "-hooks=/etc/hooks/hooks.json", "-template", "-hotreload", "-verbose" ]
COPY . /etc/hooks
