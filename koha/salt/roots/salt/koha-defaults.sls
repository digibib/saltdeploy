##########
# KOHA DEFAULTS STATE
##########

# defaults file with libraries and item types
/home/vagrant/defaults.sql.gz:
  file.managed:
    - source: salt://files/defaults.sql.gz


# disable zebra rebuild cronjob
disable_zebracron:
  file.comment:
    - name: /etc/cron.d/koha-common
    - regex: ^.+koha-rebuild-zebra
