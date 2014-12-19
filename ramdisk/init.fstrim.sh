#!/res/busybox sh

exec 2>&1 > /dev/kmsg

export PATH=/res/asset:$PATH

fstrim -v /system
fstrim -v /cache
fstrim -v /preload
fstrim -v /data

sync
