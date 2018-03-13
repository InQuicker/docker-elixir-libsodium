FROM elixir:1.5.3-slim

ENV LIBSODIUM_VERSION=1.0.16

RUN DEBIAN_FRONTEND=noninteractive \
    && runtimeDeps=' \
        ca-certificates \
        g++ \
        gcc \
        git-core \
        make \
      ' \
    && buildDeps=' \
        wget \
      ' \
    && apt-get -qq update \
    && apt-get -y --no-install-recommends install $runtimeDeps \
    && apt-get -y --no-install-recommends install $buildDeps \
    && wget https://github.com/jedisct1/libsodium/releases/download/$LIBSODIUM_VERSION/libsodium-$LIBSODIUM_VERSION.tar.gz \
    && tar xzf libsodium-$LIBSODIUM_VERSION.tar.gz \
    && cd libsodium-$LIBSODIUM_VERSION \
    && ./configure --prefix=/usr \
    && make \
    && make install \
    && apt-get purge -y --auto-remove $buildDeps \
    && rm -rf /libsodium-$LIBSODIUM_VERSION.tar.gz /libsodium-$LIBSODIUM_VERSION \
    && rm -rf /var/lib/apt/lists/*

CMD ["iex"]
