#!/bin/bash
# /usr/local/bin/clientserver.sh
# start -- stop clientserver 
# stops/starts nfs-server and unmounts/mount client iso images


start_clientserver() {
  echo "Starter klientserver"
  echo "============="
  mount -o loop,ro /tftpboot/boot/newimages/mycelimage-newest.iso /tftpboot/boot/mounts/mycelimage/
  mount -o loop,ro /tftpboot/boot/newimages/searchstation-newest.iso /tftpboot/boot/mounts/searchstation/
  /etc/init.d/nfs-kernel-server start
}

stop_clientserver() {
  echo "Stopper klientserver"
  echo "============="
  /etc/init.d/nfs-kernel-server stop
  umount /dev/loop*
}



case $1 in
  start)
    start_clientserver
    ;;
  stop)
    stop_clientserver
    ;;
  restart)
    stop_clientserver
    start_clientserver
    ;;
  *)
    echo "Usage: clientserver {start|stop|restart}"
  exit 1
esac

exit 0


