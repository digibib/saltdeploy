##########
# KOHA DEFAULTS STATE
##########

# defaults file with libraries and item types
/tmp/defaults.sql.gz:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/defaults.sql.gz


# disable zebra rebuild cronjob
disable_zebracron:
  file.comment:
    - name: /etc/cron.d/koha-common
    - regex: ^\*.+koha-rebuild-zebra
