FROM centos:centos7

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.14.0.3/s6-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C /

RUN set -x \
    && yum -y update \
    && yum -y install epel-release curl wget gc gcc gcc-c++ pcre-devel zlib-devel make wget openssl-devel libxml2-devel libxslt-devel gd-devel perl-ExtUtils-Embed GeoIP-devel gperftools gperftools-devel libatomic_ops-devel perl-ExtUtils-Embed gcc automake autoconf apr-util-devel gc gcc gcc-c++ pcre-devel zlib-devel make wget openssl-devel libxml2-devel libxslt-devel gd-devel perl-ExtUtils-Embed GeoIP-devel gperftools gperftools-devel libatomic_ops-devel perl-ExtUtils-Embed \
    && yum clean all \
    && curl -L https://github.com/duy13/vDDoS-Protection/raw/master/latest.sh -o latest.sh \
    && chmod 700 latest.sh \
    && bash latest.sh

COPY website.conf /vddos/conf.d/website.conf
COPY service /etc/services.d/vddos/run

EXPOSE 80
ENTRYPOINT ["/init"]
