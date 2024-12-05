#!/bin/bash

docker compose \
    -f ./tf-box/compose.yml \
    --env-file .env \
    run -it --rm -e "TERM=xterm-256color" \
    terraform ${@}
