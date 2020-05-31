#!/bin/bash
# Mount a virtualbox shared folder inside a VM

if [ "$#" -ne 2 ]; then
	echo "First argument: Name of Share; Second Argument: Mountpoint"
	exit 1
fi

if [ "$(id -u)" != "0" ]; then
	echo "This script must be run as root" 1>&2
	exit 1
fi

mount -t vboxsf -o uid=1000,gid=1000,rw,dmode=700,fmode=600 $1 $2
