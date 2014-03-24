##########
# KLIENTSERVER FOR DEICHMAN
# BASED ON UBUNTU SAUCY SERVER 64bit
##########

installpkgs:
  pkg.latest:
    - pkgs:
      - language-pack-nb
      - python-software-properties
      - software-properties-common
      - nfs-kernel-server
      - isc-dhcp-server
      - subversion
      - syslinux
      - tftpd-hpa
      - curl
      - screen
      - openssh-server
    - skip_verify: True

##########
# CONFIG FILES
##########

/etc/network/interfaces:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/network-interfaces

/etc/default/tftpd-hpa:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/tftpd-hpa

/etc/sysctl.conf:
  file.uncomment:
    - regex: net\.ipv4\.ip_forward=1

#iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
#echo 1 | tee /proc/sys/net/ipv4/ip_forward

/etc/iptables.up.rules:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/iptables.up.rules

/etc/default/isc-dhcp-server:
  file.managed:
    - template: jinja
    - source: {{ pillar['saltfiles'] }}/isc-dhcp-server

/etc/dhcp/dhcpd.conf:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/dhcpd.conf

/etc/exports:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/nfs-exports

/usr/local/bin/clientserver.sh:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/clientserver.sh
    - file_mode: 700

##########
# TFTPBOOT FOLDER STRUCTURE
##########

/tftpboot:
  file.recurse:
    - template: jinja
    - file_mode: 644
    - source: {{ pillar['saltfiles'] }}/tftpboot
    - include_empty: True

##########
# SERVICES
##########

networking:
  service:
    - running
    - watch:
      - file: /etc/network/interfaces
    - require:
      - file: /etc/iptables.up.rules

isc-dhcp-server:
  service:
    - running
    - watch:
      - file: /etc/dhcp/dhcpd.conf
      - file: /etc/default/isc-dhcp-server
    - require:
      - file: /etc/default/isc-dhcp-server

nfs-kernel-server:
  service:
    - running
    - watch: 
      - file: /etc/exports

##########
# IMAGES
##########

# mount:
#   cmd.run:
#     - name: mount -o loop,ro /tftpboot/boot/newimages/mycelimage-newest.iso /tftpboot/boot/mounts/mycelimage
#     - require: 
#       - file: /tftpboot
#       - service: nfs-kernel-server