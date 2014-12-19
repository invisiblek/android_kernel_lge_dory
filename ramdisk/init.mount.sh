#!/res/busybox sh

exec 2>&1 > /dev/kmsg

export PATH=/res/asset:$PATH

if [ -e /data/system-bind ] ; then
	chown 0.0 /data/system-bind
	chmod 755 /data/system-bind
	mount --bind /data/system-bind /system
	mount -o remount,suid,dev /system
else
	mount -t ext4 -o ro,noatime,nodiratime,data=ordered,barrier=1,nodiscard /dev/block/platform/msm_sdcc.1/by-name/system /system
	mount -t f2fs -o ro,noatime,nodiratime,background_gc=off,nodiscard /dev/block/platform/msm_sdcc.1/by-name/system /system
fi

touch /dev/block/mounted
