#!/usr/bin/env bash
#
# ----------------------------------------------------------------------
# boot2docker
# ----------------------------------------------------------------------

if [ -x "$(command -v boot2docker)" ] && [ "$(boot2docker status)" = "running" ]
then
  $(boot2docker shellinit)
fi
