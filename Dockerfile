FROM ubuntu:20.04
# Instructions based on # * https://switch2osm.org/serving-tiles/manually-building-a-tile-server-20-04-lts/
# https://github.com/Overv/openstreetmap-tile-server/blob/master/Dockerfile
# https://github.com/openstreetmap/mod_tile/blob/master/docs/build/building_on_ubuntu_20_04.md

ARG DEBIAN_FRONTEND=noninteractive
ARG MOD_TILE_VERSION=0.6.1

RUN apt-get update \
    && apt-get install -y --no-install-recommends build-essential \
    ca-certificates \
    autoconf \
    apache2-dev \
    libcairo2-dev \
    libcurl4-gnutls-dev \
    libglib2.0-dev \
    libiniparser-dev \
    libmapnik-dev \
    apache2 \
    git \
    && apt-get clean autoclean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/

# Setup env
RUN ln -snf /etc/localtime /usr/share/zoneinfo/America/Vancouver \
    && adduser --disabled-password --gecos "" render

RUN git clone -b $MOD_TILE_VERSION https://github.com/openstreetmap/mod_tile.git /usr/local/src/mod_tile \
    && cd /usr/local/src/mod_tile/ \
    && ./autogen.sh \
    && ./configure \
    && make \
    && make install \
    && make install-mod_tile \
    && mkdir -p /etc/renderd /var/run/renderd /var/run/apache2 \
    && chown render /etc/renderd /var/run/renderd \
    && chown -R www-data:www-data /var/log/apache2 \
    && chown -R www-data:www-data  /var/run/apache2 
    
COPY run.sh /
ENTRYPOINT ["/run.sh"]
CMD []

EXPOSE 8080
USER www-data
