FROM golang:1.18 as builder
WORKDIR /src/github.com/rf152/prometheus-vmware-exporter
COPY ./ /src/github.com/rf152/prometheus-vmware-exporter
RUN go get github.com/prometheus/client_golang/prometheus/promhttp github.com/sirupsen/logrus github.com/vmware/govmomi
RUN CGO_ENABLED=0 GOOS=linux go build

FROM alpine:3.8

LABEL org.opencontainers.image.source https://github.com/rf152/prometheus-vmware-exporter

COPY --from=builder /src/github.com/rf152/prometheus-vmware-exporter/prometheus-vmware-exporter /usr/bin/prometheus-vmware-exporter
EXPOSE 9512
ENTRYPOINT ["prometheus-vmware-exporter"]
