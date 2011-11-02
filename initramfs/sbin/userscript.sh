#!/system/bin/sh -x
# Remount filesystems RW
exec > /data/local/userscript.log 2>&1
/sbin/busybox mount -o remount,rw / /
/sbin/busybox mount -o remount,rw /dev/block/mmcblk0p9 /system
FILESIZE=$(/sbin/busybox cat /data/local/LoStKernel-Ver|wc -c)
installbb() 
{
/sbin/busybox --install -s /system/xbin
/sbin/busybox ln -s /sbin/busybox /system/bin/busybox
/sbin/busybox ln -s /sbin/busybox /system/xbin/busybox
/sbin/busybox echo "Installed BusyBox" >> /data/local/LoStKernel-Ver
sync
}

installsu()
{
/sbin/busybox chmod 06755 /sbin/su
/sbin/busybox cp -f /sbin/su /system/bin/su
/sbin/busybox chmod 06755 /system/bin/su
/sbin/busybox ln -s /system/bin/su /system/xbin/su
/sbin/busybox rm -rf /bin/su
/sbin/busybox rm -rf /sbin/su
/sbin/busybox echo "Installed SU Binary" >> /data/local/LoStKernel-Ver
}

if /sbin/busybox test "$FILESIZE" -ge "10000"; then
	/sbin/busybox rm /data/local/LoStKernel-Ver
fi

/sbin/busybox echo "Starting Boot Script - " $(/sbin/busybox date) >> /data/local/LoStKernel-Ver
/sbin/busybox echo $(/sbin/busybox uname -a) >> /data/local/LoStKernel-Ver

if /sbin/busybox test ! -e "/system/bin/su"; then
	if /sbin/busybox test ! -e "/system/xbin/su"; then
	installsu
	fi
else
/sbin/busybox chmod 06755 /system/bin/su
/sbin/busybox chmod 06755 /system/xbin/su
/sbin/busybox rm -rf /bin/su
/sbin/busybox rm -rf /sbin/su
fi

if /sbin/busybox test ! -f "/system/app/Superuser.apk"; then
	if /sbin/busybox test ! -f "/data/app/Superuser.apk"; then
		if /sbin/busybox test ! -f "/data/app/com.noshufou.android.su"*; then
			/sbin/busybox cp /sbin/superuser.apk /data/app/superuser.apk
			/sbin/busybox echo "Installed SuperUser.apk" >> /data/local/LoStKernel-Ver
		fi
	fi
fi
/sbin/busybox rm /sbin/superuser.apk
# Enable init.d support
if /sbin/busybox test -d "/system/etc/init.d"; then
	/sbin/busybox run-parts /system/etc/init.d
	/sbin/busybox echo "Init.d Started" >> /data/local/LoStKernel-Ver
	sync
fi

#setup proper passwd and group files for 3rd party root access
# Thanks DevinXtreme
if /sbin/busybox test ! -f "/system/etc/passwd"; then
	/sbin/busybox echo "root::0:0:root:/data/local:/system/bin/sh" > /system/etc/passwd
	/sbin/busybox chmod 0666 /system/etc/passwd
fi

if /sbin/busybox test ! -f "/system/etc/group"; then
	/sbin/busybox echo "root::0:" > /system/etc/group
	/sbin/busybox chmod 0666 /system/etc/group
fi

# fix busybox DNS while system is read-write
if /sbin/busybox test ! -f "/system/etc/resolv.conf"; then
	/sbin/busybox echo "nameserver 8.8.8.8" >> /system/etc/resolv.conf
	/sbin/busybox echo "nameserver 8.8.4.4" >> /system/etc/resolv.conf
fi

# patch to prevent certain malware apps
if /sbin/busybox test -f "/system/bin/profile"; then
	/sbin/busybox rm /system/bin/profile
fi

/sbin/busybox touch /system/bin/profile
/sbin/busybox echo "Malware Patch" >> /data/local/LoStKernel-Ver
/sbin/busybox chmod 644 /system/bin/profile
# remove bad BB installs
/sbin/busybox ls -1 /system/bin | while read line
  do
    if /sbin/busybox test -L "/system/bin/$line"; then
        if /sbin/busybox test "$(/sbin/busybox basename `/sbin/busybox readlink /system/bin/$line`)" = "busybox"; then
			/sbin/busybox rm /system/bin/${line}
			/sbin/busybox echo "Removing Bad BusyBox Install - /system/bin/"${line} >> /data/local/LoStKernel-Ver
			for a in cat chmod chown cmp date dd df dmesg geteven getprop hd id ifconfig iftop insmod ioctl ionice kill ln log ls lsmod lsof mkdir mount mv nandread netstat newfs_msdos notify printenv ps reboot renice rm rmdir rmmod route schedtop sendevent setconsole setprop sleep smd start stop sync top umount uptime vmstat watchprops wipe 
				do
					if [ ${line} == ${a} ]; then
						/sbin/busybox ln -s /system/bin/toolbox  /system/bin/${line}
						/sbin/busybox echo "Relinked /system/bin/"${line}" to toolbox" >> /data/local/LoStKernel-Ver
					fi
				done
		fi
		if /sbin/busybox test "$(/sbin/busybox basename `/sbin/busybox readlink /system/bin/$line`)" = "recovery"; then
			/sbin/busybox rm /system/bin/${line}
			/sbin/busybox echo "Removing Bad BusyBox Install - /system/bin/"${line} >> /data/local/LoStKernel-Ver
			for a in cat chmod chown cmp date dd df dmesg geteven getprop hd id ifconfig iftop insmod ioctl ionice kill ln log ls lsmod lsof mkdir mount mv nandread netstat newfs_msdos notify printenv ps reboot renice rm rmdir rmmod route schedtop sendevent setconsole setprop sleep smd start stop sync top umount uptime vmstat watchprops wipe 
				do
					if [ ${line} == ${a} ]; then
						/sbin/busybox ln -s /system/bin/toolbox  /system/bin/${line}
						/sbin/busybox echo "Relinked /system/bin/"${line}" to toolbox" >> /data/local/LoStKernel-Ver
					fi
				done
		fi
	fi
  done
/sbin/busybox rm /system/bin/busybox
if /sbin/busybox test ! -e "/system/xbin/busybox"; then
installbb
else
busybox rm -Rf /sbin/busybox
fi
# remount read only and continue
sync
busybox echo "Bootscript Ended - " $(/sbin/busybox date)  >> /data/local/LoStKernel-Ver
busybox mount -o remount,ro / /
busybox mount -o remount,ro /dev/block/mmcblk0p9 /system
