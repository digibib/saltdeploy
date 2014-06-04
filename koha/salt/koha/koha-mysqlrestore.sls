########
# KOHA ROLLBACK MYSQL STATE
########

# purge db first if backup exists
purgedb:
  cmd.run:
    - unless: test -f /var/spool/koha/{{ pillar['koha']['instance'] }}/mysqldump.sql
    - name: "mysql -u root -e \"DROP DATABASE IF EXISTS koha_{{ pillar['koha']['instance'] }}\""

mysqlrestore:
  cmd.run:
    - name: mysql -u root koha_{{ pillar['koha']['instance'] }} < /var/spool/koha/{{ pillar['koha']['instance'] }}/mysqldump.sql
    - require:
      - cmd: purgedb

# make sure backup is removed after
removedump:
  cmd.run:
    - name: rm -rf /var/spool/koha/{{ pillar['koha']['instance'] }}/mysqldump.sql
    - require:
      - cmd: mysqlrestore