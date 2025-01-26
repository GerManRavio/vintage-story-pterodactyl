FROM ubuntu:latest AS downloaded
WORKDIR /downloads

ARG VERSION="1.20.3"
ARG RELEASE_TYPE="stable"

RUN apt update
RUN apt install -y wget

# https://cdn.vintagestory.at/gamefiles/stable/vs_server_linux-x64_1.20.3.tar.gz
RUN wget "https://cdn.vintagestory.at/gamefiles/${RELEASE_TYPE}/vs_server_linux-x64_${VERSION}.tar.gz"
RUN tar xzf "vs_server_linux-x64_${VERSION}.tar.gz"
RUN rm "vs_server_linux-x64_${VERSION}.tar.gz"

# Run server
FROM mcr.microsoft.com/dotnet/runtime:7.0 AS base
WORKDIR /home/container

COPY --from=downloaded /downloads /home/container

VOLUME [ "/home/container" ]
RUN chmod +x ./VintagestoryServer

EXPOSE 42420/tcp
CMD ./VintagestoryServer --dataPath ./data