FROM alpine:3.8 AS go-builder
LABEL builder=true

ENV CGO_ENABLED=0
ENV GOPATH /go
ENV APPPATH $GOPATH/src/github.com/adnanh/webhook

RUN adduser -DH user
RUN apk add --update -t build-deps go git mercurial libc-dev gcc libgcc
RUN go get -u github.com/adnanh/webhook \
 && cd $APPPATH \
 && go build \
    -a \
    -ldflags '-s -w -extldflags "-static"' \
    -o /bin/webhook


FROM alpine:3.8
LABEL runtime=true

EXPOSE 9000
WORKDIR /app

RUN apk add --no-cache ca-certificates curl \
    && mkdir /etc/hooks

COPY --from=go-builder /bin/webhook /app/webhook
COPY --from=go-builder /etc/passwd /etc/passwd
USER user

CMD [ "/app/webhook", "-port=9000", "-hooks=/etc/hooks/hooks.json", "-template", "-hotreload", "-verbose" ]
COPY . /etc/hooks
