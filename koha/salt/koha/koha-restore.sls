##########
# KOHA RESTORE STATE
##########

# include:
#   - koha.koha-create

##########
# RESTORE FILES
##########

# 500ex database for knakk
/tmp/{{ pillar['kohaname'] }}-2013-10-22.sql.gz:
  file.managed:
    - source: {{ pillar['filerepo'] }}/{{ pillar['kohaname'] }}-2013-10-22.sql.gz
    - source_hash: md5=b3367bad920b42948322d3f735784a99

# 500ex file structure for knakk
/tmp/{{ pillar['kohaname'] }}-2013-10-22.tar.gz:
  file.managed:
    - source: {{ pillar['filerepo'] }}/{{ pillar['kohaname'] }}-2013-10-22.tar.gz
    - source_hash: md5=36bb6ce2496f2570ae8c22c4a038fe5f

##########
# RESTORE COMMANDS
##########

restore{{ pillar['kohaname'] }}500ex:
  cmd.run:
    - name: koha-restore /tmp/{{ pillar['kohaname'] }}-2013-10-22.sql.gz /tmp/{{ pillar['kohaname'] }}-2013-10-22.tar.gz
    - require:
      - file: /tmp/{{ pillar['kohaname'] }}-2013-10-22.sql.gz
      - file: /tmp/{{ pillar['kohaname'] }}-2013-10-22.tar.gz
      - cmd: createkohadb