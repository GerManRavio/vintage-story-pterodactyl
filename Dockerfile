FROM ghcr.io/pterodactyl/installers:debian

LABEL author=GerManRavio, email=<germanravio@gmail.com>

RUN apt-get update && apt-get install -y curl ca-certificates openssl git tar bash sqlite3 fontconfig screen procps

RUN useradd -m -d /home/container -s /bin/bash -r container

RUN wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN rm packages-microsoft-prod.deb 
RUN apt-get update && apt install -y dotnet-runtime-7.0

USER container
ENV USER=container HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]