FROM ghcr.io/pterodactyl/installers:debian AS downloaded

LABEL GerManRavio, <germanravio@gmail.com>

RUN apt update && apt install -y curl ca-certificates openssl git tar bash sqlite3 fontconfig && useradd -m -d /home/container -s /bin/bash -r container

USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container

FROM mcr.microsoft.com/dotnet/runtime:7.0 AS base

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]

RUN chmod +x ./VintagestoryServer

