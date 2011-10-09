#!/sbin/sh
exec > /dev/null 2>&1;
busybox ls -1 /system/bin | while read line
  do
    if busybox [ "$(busybox basename `busybox readlink /system/bin/$line`)" = "busybox" ]; then
		busybox rm /system/bin/${line};
    fi;
    if busybox [ "$(busybox basename `busybox readlink /system/bin/$line`)" = "recovery" ]; then
		busybox rm /system/bin/${line};
    fi;
  done
busybox ln -s /system/bin/toolbox  /system/bin/cat;
busybox ln -s /system/bin/toolbox  /system/bin/chmod;
busybox ln -s /system/bin/toolbox  /system/bin/chown;
busybox ln -s /system/bin/toolbox  /system/bin/cmp;
busybox ln -s /system/bin/toolbox  /system/bin/date;
busybox ln -s /system/bin/toolbox  /system/bin/dd;
busybox ln -s /system/bin/toolbox  /system/bin/df;
busybox ln -s /system/bin/toolbox  /system/bin/dmesg;
busybox ln -s /system/bin/toolbox  /system/bin/getevent;
busybox ln -s /system/bin/toolbox  /system/bin/getprop;
busybox ln -s /system/bin/toolbox  /system/bin/hd;
busybox ln -s /system/bin/toolbox  /system/bin/id;
busybox ln -s /system/bin/toolbox  /system/bin/ifconfig;
busybox ln -s /system/bin/toolbox  /system/bin/iftop;
busybox ln -s /system/bin/toolbox  /system/bin/insmod;
busybox ln -s /system/bin/toolbox  /system/bin/ioctl;
busybox ln -s /system/bin/toolbox  /system/bin/ionice;
busybox ln -s /system/bin/toolbox  /system/bin/kill;
busybox ln -s /system/bin/toolbox  /system/bin/ln;
busybox ln -s /system/bin/toolbox  /system/bin/log;
busybox ln -s /system/bin/toolbox  /system/bin/ls;
busybox ln -s /system/bin/toolbox  /system/bin/lsmod;
busybox ln -s /system/bin/toolbox  /system/bin/lsof;
busybox ln -s /system/bin/toolbox  /system/bin/mkdir;
busybox ln -s /system/bin/toolbox  /system/bin/mount;
busybox ln -s /system/bin/toolbox  /system/bin/mv;
busybox ln -s /system/bin/toolbox  /system/bin/nandread;
busybox ln -s /system/bin/toolbox  /system/bin/netstat;
busybox ln -s /system/bin/toolbox  /system/bin/newfs_msdos;
busybox ln -s /system/bin/toolbox  /system/bin/notify;
busybox ln -s /system/bin/toolbox  /system/bin/printenv;
busybox ln -s /system/bin/toolbox  /system/bin/ps;
busybox ln -s /system/bin/toolbox  /system/bin/reboot;
busybox ln -s /system/bin/toolbox  /system/bin/renice;
busybox ln -s /system/bin/toolbox  /system/bin/rm;
busybox ln -s /system/bin/toolbox  /system/bin/rmdir;
busybox ln -s /system/bin/toolbox  /system/bin/rmmod;
busybox ln -s /system/bin/toolbox  /system/bin/route;
busybox ln -s /system/bin/toolbox  /system/bin/schedtop;
busybox ln -s /system/bin/toolbox  /system/bin/sendevent;
busybox ln -s /system/bin/toolbox  /system/bin/setconsole;
busybox ln -s /system/bin/toolbox  /system/bin/setprop;
busybox ln -s /system/bin/toolbox  /system/bin/sleep;
busybox ln -s /system/bin/toolbox  /system/bin/smd;
busybox ln -s /system/bin/toolbox  /system/bin/start;
busybox ln -s /system/bin/toolbox  /system/bin/stop;
busybox ln -s /system/bin/toolbox  /system/bin/sync;
busybox ln -s /system/bin/toolbox  /system/bin/top;
busybox ln -s /system/bin/toolbox  /system/bin/umount;
busybox ln -s /system/bin/toolbox  /system/bin/uptime;
busybox ln -s /system/bin/toolbox  /system/bin/vmstat;
busybox ln -s /system/bin/toolbox  /system/bin/watchprops;
busybox ln -s /system/bin/toolbox  /system/bin/wipe;
busybox rm /system/bin/busybox;
