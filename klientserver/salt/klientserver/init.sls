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
      - iptables
      - bash-completion
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
    - mode: 750

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
# IMAGES
##########

# make sure dirs exist
mkdirs:
  cmd.run:
  - name: mkdir -p /tftpboot/boot/{newimages/mycelimage,mounts/mycelimage}

mycelimage:
  file.managed:
    - name: /tftpboot/boot/newimages/mycelimage-newest.iso
    - source: {{ pillar['filerepo'] }}/newimages/mycelimage-newest.iso
    - source_hash: {{ pillar['filerepo'] }}/newimages/mycelimage-newest.md5

# mount:
#   cmd.run:
#     - name: mount -o loop,ro,remount /tftpboot/boot/newimages/mycelimage-newest.iso /tftpboot/boot/mounts/mycelimage
#     - require:
#       - cmd: mkdirs
#       - file: mycelimage
#       - service: nfs-kernel-server

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
    - require:
      - file: /etc/exports

remount:
  cmd.run:
    - name: /usr/local/bin/clientserver.sh restart
    - watch: 
      - service: nfs-kernel-server
      - file: mycelimage