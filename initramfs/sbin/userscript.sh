#!/system/bin/sh
# Remount filesystems RW
/sbin/busybox mount -o remount,rw / /;
/sbin/busybox mount -o remount,rw /dev/block/mmcblk0p9 /system;
FILESIZE=$(cat /data/local/LoStKernel-Ver|wc -c)
/sbin/busybox test $FILESIZE -ge 10000 && rm /data/local/LoStKernel-Ver
echo "Starting Boot Script - " $(date) >> /data/local/LoStKernel-Ver;

/sbin/busybox test ! -e "/system/xbin/busybox" && installbb();
/sbin/busybox test ! -e "/system/bin/su" && /sbin/busybox test ! -e "/system/xbin/su" && installsu();
# touch /data/local/LoStKernel-Ver

installbb() 
{
/sbin/busybox --install -s /system/xbin
/sbin/busybox ln -s /sbin/busybox /system/bin/busybox
/sbin/busybox ln -s /sbin/busybox /system/xbin/busybox
echo "Installed BusyBox" >> /data/local/LoStKernel-Ver
sync
};

installsu()
{
chmod 06755 /sbin/su
/sbin/busybox cp -f /sbin/su /system/bin/su
chmod 06755 /system/bin/su
/sbin/busybox ln -s /system/bin/su /system/xbin/su
/sbin/busybox rm -rf /bin/su
/sbin/busybox rm -rf /sbin/su
echo "Installed SU Binary" >> /data/local/LoStKernel-Ver
};
/sbin/busybox sh /sbin/bbuninstall.sh;
/sbin/busybox test ! -f "/system/app/Superuser.apk" && /sbin/busybox test ! -f "/data/app/Superuser.apk" && /sbin/busybox test ! -f "/data/app/com.noshufou.android.su"* && /sbin/busybox cp /sbin/superuser.apk /data/app/superuser.apk && echo "Installed SuperUser.apk" >> /data/local/LoStKernel-Ver;
/sbin/busybox rm /sbin/superuser.apk;
# Enable init.d support
/sbin/busybox test -d "/system/etc/init.d" &&  /sbin/busybox run-parts /system/etc/init.d && echo "Init.d Started" >> /data/local/LoStKernel-Ver && sync;

#setup proper passwd and group files for 3rd party root access
# Thanks DevinXtreme
/sbin/busybox test ! -f "/system/etc/passwd" &&	echo "root::0:0:root:/data/local:/system/bin/sh" > /system/etc/passwd && chmod 0666 /system/etc/passwd;
/sbin/busybox test ! -f "/system/etc/group" && echo "root::0:" > /system/etc/group && chmod 0666 /system/etc/group;

# fix busybox DNS while system is read-write
/sbin/busybox test ! -f "/system/etc/resolv.conf" && echo "nameserver 8.8.8.8" >> /system/etc/resolv.conf && echo "nameserver 8.8.4.4" >> /system/etc/resolv.conf;

# patch to prevent certain malware apps
/sbin/busybox test -f "/system/bin/profile" && busybox rm /system/bin/profile;
touch /system/bin/profile && echo "Malware Patch" >> /data/local/LoStKernel-Ver;
chmod 644 /system/bin/profile;
# remount read only and continue
sync;
echo "Bootscript Ended - " $(date)  >> /data/local/LoStKernel-Ver;
busybox  mount -o remount,ro / /;
busybox  mount -o remount,ro /dev/block/mmcblk0p9 /system;
