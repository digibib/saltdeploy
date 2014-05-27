########
# KOHA ROLLBACK MYSQL STATE
########

# purge db first if backup exists
purgedb:
  cmd.run:
    - unless: test -f /var/spool/koha/{{ pillar['kohaname'] }}/mysqldump.sql
    - name: "mysql -u root -e \"DROP DATABASE IF EXISTS koha_{{ pillar['kohaname'] }}\""

mysqlrestore:
  cmd.run:
    - name: mysql -u root koha_{{ pillar['kohaname'] }} < /var/spool/koha/{{ pillar['kohaname'] }}/mysqldump.sql
    - require:
      - cmd: purgedb

# make sure backup is removed after
removedump:
  cmd.run:
    - name: rm -rf /var/spool/koha/{{ pillar['kohaname'] }}/mysqldump.sql
    - require:
      - cmd: mysqlrestore