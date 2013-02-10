# prefer UTF-8
export LC_CTYPE="en_US.UTF-8"

# notify of bg job completion immediately
set -o notify

# disable core dumps
ulimit -S -c 0

# default umask
umask 0022

# increase ulimit to something sane, for grunt watch etc.
if [ "$(ulimit -n)" != "unlimited" ] ; then
    ulimit -n 16384 > /dev/null 2>&1 || \
    ulimit -n 8192 > /dev/null 2>&1 || \
    ulimit -n 4096 > /dev/null 2>&1 || \
    ulimit -n 2048 > /dev/null 2>&1 || \
    ulimit -n 1024 > /dev/null 2>&1 || \
    ulimit -n 512 > /dev/null 2>&1
fi

export EDITOR='subl'
