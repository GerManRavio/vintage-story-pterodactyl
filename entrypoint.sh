#!/bin/bash

TZ=${TZ:-UTC}
export TZ

PARSED=$(echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g' | eval echo "$(cat -)")

printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0m%s\n" "$PARSED"

cd /home/container

curl -sSL -o "server.tar.gz" "https://cdn.vintagestory.at/gamefiles/${RELEASE_TYPE}/vs_server_linux-x64_${VERSION}.tar.gz"
tar -xzvf "server.tar.gz"
rm "server.tar.gz"

exec env ${PARSED}
