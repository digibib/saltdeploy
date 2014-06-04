########
# KOHA BACKUP MYSQL STATE
########

mysqldump:
  cmd.run:
    - name: mysqldump -u root koha_{{ pillar['koha']['instance'] }} --ignore-table=koha_{{ pillar['koha']['instance'] }}.sessions --ignore-table=koha_{{ pillar['koha']['instance'] }}.zebraqueue > /var/spool/koha/{{ pillar['koha']['instance'] }}/mysqldump.sql

