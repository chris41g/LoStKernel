#!/bin/bash
#
# update_modules.sh
#
#
# 2011 nubecoder
# http://www.nubecoder.com/
#


#define base paths
P_DIR="/home/chris41g/android/LoStKernel"
SRC_BASE="$P_DIR/Kernel/drivers"
DST_BASE="initramfs/lib/modules"
CC_STRIP="/home/chris41g/arm-2009q3/bin/arm-none-linux-gnueabi-strip"

COPY_WITH_ECHO()
{
	local SRC=$1
	local DST=$2
	echo "Copying $SRC to $DST_BASE/$DST"
	cp "$SRC_BASE/$SRC" "$P_DIR/$DST_BASE/$DST"
}
STRIP_WITH_ECHO()
{
	local DST=$1
	echo "Stripping $DST_BASE/$DST"
	$CC_STRIP -d --strip-unneeded "$P_DIR/$DST_BASE/$DST"
}
SHOW_HELP()
{
	echo "=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]"
	echo "Usage options for $0:"
	echo "cp | copy : Copy modules to initramfs."
	echo "st | strip : Strip modules in initramfs."
	echo "=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]"
	exit 1
}

if [ "$1" == "cp" ] || [ "$1" == "copy" ] ; then
	#copy modules
	COPY_WITH_ECHO "bluetooth/bthid/bthid.ko" "bthid.ko"
	COPY_WITH_ECHO "samsung/j4fs/j4fs.ko" "j4fs.ko"
	COPY_WITH_ECHO "scsi/scsi_wait_scan.ko" "scsi_wait_scan.ko"
	COPY_WITH_ECHO "net/wireless/bcm4330/dhd.ko" "dhd.ko"
	COPY_WITH_ECHO "samsung/vibetonz/vibrator.ko" "vibrator.ko"
	COPY_WITH_ECHO "staging/westbridge/astoria/switch/cyasswitch.ko" "cyasswitch.ko"
	
	exit 0
fi

if [ "$1" == "st" ] || [ "$1" == "strip" ] ; then
	#strip modules
	STRIP_WITH_ECHO "bthid.ko"
	STRIP_WITH_ECHO "cyasswitch.ko"
	STRIP_WITH_ECHO "j4fs.ko"
	#STRIP_WITH_ECHO "dhd.ko"
	#STRIP_WITH_ECHO "vibrator.ko"
	STRIP_WITH_ECHO "scsi_wait_scan.ko"
	exit 0
fi

SHOW_HELP

