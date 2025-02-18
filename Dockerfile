FROM debian:buster-slim

# Set noninteractive mode (no prompts, accept defaults everywhere)
ENV DEBIAN_FRONTEND=noninteractive

# Set default variables
ENV AFP_SPOTLIGHT no
ENV AFP_ZEROCONF no
ENV AFP_NAME Netatalk-server
ENV AFP_SIZE_LIMIT 0

RUN \
    set -ex \
    && apt-get update \
    && apt-get install \
      --no-install-recommends \
      --fix-missing \
      --assume-yes \
        netatalk \
        avahi-daemon \
        dbus \
        lsof \
        procps \
        python3-dbus \
        tracker \
        quota \
    &&  apt-get --quiet --yes autoclean \
    &&  apt-get --quiet --yes autoremove \
    &&  apt-get --quiet --yes clean \
    && rm -rf /var/lib/apt/lists/*

COPY docker-healthcheck.sh /docker-healthcheck.sh
COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY afp.conf /etc/netatalk/

HEALTHCHECK CMD ["/docker-healthcheck.sh"]

EXPOSE 548

CMD ["/docker-entrypoint.sh"]
