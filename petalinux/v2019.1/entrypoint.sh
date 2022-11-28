#! /bin/bash
echo "source /opt/petalinux/settings.sh" > ~/.bashrc

exec "$@"