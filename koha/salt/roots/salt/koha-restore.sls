##########
# KOHA RESTORE STATE
##########

include:
  - koha-create

##########
# RESTORE FILES
##########

# 500ex database for knakk
/home/vagrant/knakk-2013-10-22.sql.gz:
  file.managed:
    - source: http://171.23.133.203/saltfiles/koha/knakk-2013-10-22.sql.gz
    - source_hash: md5=b3367bad920b42948322d3f735784a99

# 500ex file structure for knakk
/home/vagrant/knakk-2013-10-22.tar.gz:
  file.managed:
    - source: http://171.23.133.203/saltfiles/koha/knakk-2013-10-22.tar.gz
    - source_hash: md5=36bb6ce2496f2570ae8c22c4a038fe5f

##########
# RESTORE COMMANDS
##########

restore{{ opts['kohaname'] }}500ex:
  cmd.run:
    - name: sudo koha-restore {{ opts['kohaname'] }}-2013-10-22.sql.gz {{ opts['kohaname'] }}-2013-10-22.tar.gz > /dev/null 2>&1
    - require:
      - file: /home/vagrant/{{ opts['kohaname'] }}-2013-10-22.sql.gz
      - file: /home/vagrant/{{ opts['kohaname'] }}-2013-10-22.tar.gz
      - cmd: createkohadb

rebuildzebra:
  cmd.run:
    - name: sudo koha-rebuild-zebra --full {{ opts['kohaname'] }}
    - watch: 
      - cmd: restore{{ opts['kohaname'] }}500ex