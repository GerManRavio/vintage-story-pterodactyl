#!/bin/bash

TZ=${TZ:-UTC}
export TZ

INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

PARSED=$(echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g' | eval echo "$(cat -)")

printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0m%s\n" "$PARSED"

cd /home/container

DOWNLOAD_URL="https://cdn.vintagestory.at/gamefiles/${RELEASE_TYPE}/vs_server_linux-x64_${VERSION}.tar.gz"
curl -sSL -o vs_server.tar.gz $DOWNLOAD_URL
tar -xzf vs_server.tar.gz
rm vs_server.tar.gz

dotnet --info

exec env ${PARSED}
