#!/sbin/sh
exec > /dev/null 2>&1;
/sbin/busybox ls -1 /system/bin | while read line
  do
    if /sbin/busybox [ "$(/sbin/busybox basename `/sbin/busybox readlink /system/bin/$line`)" = "busybox" ]; then
		/sbin/busybox rm /system/bin/${line};
    fi;
    if /sbin/busybox [ "$(/sbin/busybox basename `/sbin/busybox readlink /system/bin/$line`)" = "recovery" ]; then
		/sbin/busybox rm /system/bin/${line};
    fi;
  done
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
sync
