##########
# KOHA RESTORE FULL STATE
# - restores entire catalogue and index
# - make sure vbox has at least 40G space
##########

# include:
#   - koha.koha-create

# remove koha instance first
removekohainstance:
  cmd.run:
    - name: koha-remove {{ pillar['kohaname'] }}

##########
# RESTORE FILES
##########

# full database for knakk
/tmp/{{ pillar['kohaname'] }}-2013-11-08.sql.gz:
  file.managed:
    - source: {{ pillar['filerepo'] }}/{{ pillar['kohaname'] }}-2013-11-08.sql.gz
    - source_hash: md5=d3cbf01dd6d654f4f58ac5767ce0b98f

# full file structure for knakk
/tmp/{{ pillar['kohaname'] }}-2013-11-08.tar.gz:
  file.managed:
    - source: {{ pillar['filerepo'] }}/{{ pillar['kohaname'] }}-2013-11-08.tar.gz
    - source_hash: md5=ef2d6127c118addd1359d78fa534121e

##########
# RESTORE COMMANDS
##########

restore{{ pillar['kohaname'] }}all:
  cmd.run:
    - name: koha-restore /tmp/{{ pillar['kohaname'] }}-2013-11-08.sql.gz /tmp/{{ pillar['kohaname'] }}-2013-11-08.tar.gz > /dev/null 2>&1
    - require:
      - cmd: removekohainstance
      - file: /tmp/{{ pillar['kohaname'] }}-2013-11-08.sql.gz
      - file: /tmp/{{ pillar['kohaname'] }}-2013-11-08.tar.gz
