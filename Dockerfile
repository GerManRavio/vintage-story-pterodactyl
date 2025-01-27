FROM ghcr.io/pterodactyl/installers:debian AS downloaded

LABEL GerManRavio, <germanravio@gmail.com>

RUN apt update && apt install -y curl ca-certificates openssl git tar bash sqlite3 fontconfig && useradd -m -d /home/container -s /bin/bash -r container

USER container
ENV  USER=container HOME=/home/container DOWNLOAD_URL="https://cdn.vintagestory.at/gamefiles/${RELEASE_TYPE}/vs_server_linux-x64_${VERSION}.tar.gz"


WORKDIR /home/container
RUN curl -sSL -o vs_server.tar.gz
RUN tar xzf "vs_server_linux-x64_${VERSION}.tar.gz"
RUN rm "vs_server_linux-x64_${VERSION}.tar.gz"

FROM mcr.microsoft.com/dotnet/runtime:7.0 AS base

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
