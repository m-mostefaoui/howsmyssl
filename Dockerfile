FROM golang:1.10

EXPOSE 10080
EXPOSE 10443

ADD . /go/src/github.com/m-mostefaoui/howsmyssl

RUN go install github.com/m-mostefaoui/howsmyssl


RUN chown -R www-data /go/src/github.com/m-mostefaoui/howsmyssl

USER www-data

CMD ["/bin/bash", "-c", "howsmyssl \
    -httpsAddr=:10443 \
    -httpAddr=:10080 \
    -adminAddr=:4567 \
    -templateDir=/go/src/github.com/m-mostefaoui/howsmyssl/templates \
    -staticDir=/go/src/github.com/m-mostefaoui/howsmyssl/static \
    -vhost= localhost \
    -acmeRedirect=$ACME_REDIRECT_URL \
    -allowLogName=howsmyssl_allowance_checks \
    -cert=/go/src/github.com/m-mostefaoui/howsmyssl/certs/ssl.parcelvision.info.cer \
    -key=/go/src/github.com/m-mostefaoui/howsmyssl/certs/ssl.parcelvision.info.key"]
