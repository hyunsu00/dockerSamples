#!/usr/bin/env bash
echo "call entrypoint.sh"

sudo ./_entrypoint.sh

exec "$@"