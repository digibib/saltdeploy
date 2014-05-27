########
# KOHA BACKUP MYSQL STATE
########

mysqldump:
  cmd.run:
    - name: mysqldump -u root koha_{{ pillar['kohaname'] }} --ignore-table=koha_{{ pillar['kohaname'] }}.sessions --ignore-table=koha_{{ pillar['kohaname'] }}.zebraqueue > /var/spool/koha/{{ pillar['kohaname'] }}/mysqldump.sql

