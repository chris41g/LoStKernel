#!/system/bin/sh
# Remount filesystems RW
/sbin/busybox mount -o remount,rw / /;
/sbin/busybox mount -o remount,rw /dev/block/mmcblk0p9 /system;
FILESIZE=$(/sbin/busybox cat /data/local/LoStKernel-Ver|wc -c)
/sbin/busybox test $FILESIZE -ge 10000 && /sbin/busybox rm /data/local/LoStKernel-Ver
/sbin/busybox echo "Starting Boot Script - " $(/sbin/busybox date) >> /data/local/LoStKernel-Ver;
/sbin/busybox echo $(/sbin/busybox uname -a) >> /data/local/LoStKernel-Ver;
/sbin/busybox test ! -e "/system/xbin/busybox" && installbb();
/sbin/busybox test ! -e "/system/bin/su" && /sbin/busybox test ! -e "/system/xbin/su" && installsu();
# touch /data/local/LoStKernel-Ver

installbb() 
{
/sbin/busybox --install -s /system/xbin
/sbin/busybox ln -s /sbin/busybox /system/bin/busybox
/sbin/busybox ln -s /sbin/busybox /system/xbin/busybox
/sbin/busybox echo "Installed BusyBox" >> /data/local/LoStKernel-Ver
sync
};

installsu()
{
/sbin/busybox chmod 06755 /sbin/su
/sbin/busybox cp -f /sbin/su /system/bin/su
/sbin/busybox chmod 06755 /system/bin/su
/sbin/busybox ln -s /system/bin/su /system/xbin/su
/sbin/busybox rm -rf /bin/su
/sbin/busybox rm -rf /sbin/su
/sbin/busybox echo "Installed SU Binary" >> /data/local/LoStKernel-Ver
};
/sbin/busybox test ! -f "/system/app/Superuser.apk" && /sbin/busybox test ! -f "/data/app/Superuser.apk" && /sbin/busybox test ! -f "/data/app/com.noshufou.android.su"* && /sbin/busybox cp /sbin/superuser.apk /data/app/superuser.apk && /sbin/busybox echo "Installed SuperUser.apk" >> /data/local/LoStKernel-Ver;
/sbin/busybox rm /sbin/superuser.apk;
# Enable init.d support
/sbin/busybox test -d "/system/etc/init.d" &&  /sbin/busybox run-parts /system/etc/init.d && /sbin/busybox echo "Init.d Started" >> /data/local/LoStKernel-Ver && sync;

#setup proper passwd and group files for 3rd party root access
# Thanks DevinXtreme
/sbin/busybox test ! -f "/system/etc/passwd" &&	/sbin/busybox echo "root::0:0:root:/data/local:/system/bin/sh" > /system/etc/passwd && /sbin/busybox chmod 0666 /system/etc/passwd;
/sbin/busybox test ! -f "/system/etc/group" && /sbin/busybox echo "root::0:" > /system/etc/group && /sbin/busybox chmod 0666 /system/etc/group;

# fix busybox DNS while system is read-write
/sbin/busybox test ! -f "/system/etc/resolv.conf" && /sbin/busybox echo "nameserver 8.8.8.8" >> /system/etc/resolv.conf && /sbin/busybox echo "nameserver 8.8.4.4" >> /system/etc/resolv.conf;

# patch to prevent certain malware apps
/sbin/busybox test -f "/system/bin/profile" && /sbin/busybox rm /system/bin/profile;
/sbin/busybox touch /system/bin/profile && /sbin/busybox echo "Malware Patch" >> /data/local/LoStKernel-Ver;
/sbin/busybox chmod 644 /system/bin/profile;
# remove bad BB installs
/sbin/busybox ls -1 /system/bin | while read line
  do
    if /sbin/busybox [ "$(/sbin/busybox basename `/sbin/busybox readlink /system/bin/$line`)" = "busybox" ]; then
		/sbin/busybox rm /system/bin/${line};
		/sbin/busybox echo "Removing Bad BusyBox Install - /system/bin/"${line} >> /data/local/LoStKernel-Ver
    fi;
    if /sbin/busybox [ "$(/sbin/busybox basename `/sbin/busybox readlink /system/bin/$line`)" = "recovery" ]; then
		/sbin/busybox rm /system/bin/${line};
		/sbin/busybox echo "Removing Bad BusyBox Install - /system/bin/"${line} >> /data/local/LoStKernel-Ver
    fi;
  done
# Relink Toolbox
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/cat;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/chmod;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/chown;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/cmp;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/date;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/dd;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/df;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/dmesg;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/getevent;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/getprop;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/hd;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/id;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/ifconfig;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/iftop;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/insmod;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/ioctl;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/ionice;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/kill;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/ln;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/log;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/ls;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/lsmod;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/lsof;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/mkdir;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/mount;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/mv;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/nandread;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/netstat;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/newfs_msdos;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/notify;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/printenv;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/ps;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/reboot;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/renice;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/rm;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/rmdir;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/rmmod;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/route;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/schedtop;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/sendevent;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/setconsole;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/setprop;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/sleep;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/smd;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/start;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/stop;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/sync;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/top;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/umount;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/uptime;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/vmstat;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/watchprops;
/sbin/busybox ln -s /system/bin/toolbox  /system/bin/wipe;
/sbin/busybox rm /system/bin/busybox;
/sbin/busybox echo "Relinked Toolbox in /system/bin" >> /data/local/LoStKernel-Ver
# remount read only and continue
sync;
/sbin/busybox echo "Bootscript Ended - " $(/sbin/busybox date)  >> /data/local/LoStKernel-Ver;
/sbin/busybox mount -o remount,ro / /;
/sbin/busybox mount -o remount,ro /dev/block/mmcblk0p9 /system;
