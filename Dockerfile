FROM golang:1.10

EXPOSE 10080
EXPOSE 10443

ADD . /go/src/github.com/m-mostefaoui/howsmyssl

RUN go install github.com/m-mostefaoui/howsmyssl

# Provided by kubernetes secrets or some such
VOLUME "/certs"

RUN chown -R www-data /go/src/github.com/m-mostefaoui/howsmyssl

USER www-data

CMD ["/bin/bash", "-c", "howsmyssl \
    -httpsAddr=:10443 \
    -httpAddr=:10080 \
    -adminAddr=:4567 \
    -templateDir=/go/src/github.com/m-mostefaoui/howsmyssl/templates \
    -staticDir=/go/src/github.com/m-mostefaoui/howsmyssl/static \
    -vhost=www.howsmyssl.com \
    -acmeRedirect=$ACME_REDIRECT_URL \
    -allowListsFile=/etc/howsmyssl-allowlists/allow_lists.json \
    -googAcctConf=/secrets/howsmyssl-logging-svc-account/howsmyssl-logging.json \
    -allowLogName=howsmyssl_allowance_checks \
    -cert=/go/src/github.com/m-mostefaoui/howsmyssl/certs/ssl.parcelvision.info.crt \
    -key=/go/src/github.com/m-mostefaoui/howsmyssl/certs/ssl.parcelvision.info.key"]
