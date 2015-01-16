#!/res/busybox sh

exec 2>&1 > /dev/kmsg

export PATH=/res/asset:$PATH

mount -t ext4 -o rw,noatime,nodiratime,data=ordered,barrier=1,nodiscard /dev/block/platform/msm_sdcc.1/by-name/cache /cache
mount -t f2fs -o rw,noatime,nodiratime,background_gc=on,nodiscard /dev/block/platform/msm_sdcc.1/by-name/cache /cache
mount -t ext4 -o rw,noatime,nodiratime,data=ordered,barrier=1,nodiscard /dev/block/platform/msm_sdcc.1/by-name/userdata /data
mount -t f2fs -o rw,noatime,nodiratime,background_gc=on,nodiscard /dev/block/platform/msm_sdcc.1/by-name/userdata /data

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
