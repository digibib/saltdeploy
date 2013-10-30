##########
# KOHA RESTORE FULL STATE
# - restores entire catalogue and index
# - make sure vbox has at least 40G space
##########

include:
  - koha-create

##########
# RESTORE FILES
##########

# full database for knakk
/home/vagrant/knakk-2013-10-30.sql.gz:
  file.managed:
    - source: {{ opts['filerepo'] }}/knakk-2013-10-30.sql.gz
    - source_hash: md5=82578e870de70976bbf228bb6c526e45

# full file structure for knakk
/home/vagrant/knakk-2013-10-30.tar.gz:
  file.managed:
    - source: {{ opts['filerepo'] }}/knakk-2013-10-30.tar.gz
    - source_hash: md5=575af677290edd2000ad5ff5faad2936

##########
# RESTORE COMMANDS
##########

restore{{ opts['kohaname'] }}all:
  cmd.run:
    - name: sudo koha-restore {{ opts['kohaname'] }}-2013-10-30.sql.gz {{ opts['kohaname'] }}-2013-10-30.tar.gz > /dev/null 2>&1
    - require:
      - file: /home/vagrant/{{ opts['kohaname'] }}-2013-10-30.sql.gz
      - file: /home/vagrant/{{ opts['kohaname'] }}-2013-10-30.tar.gz
      - cmd: createkohadb