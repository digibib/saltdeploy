##########
# KOHA RESTORE STATE
##########

include:
  - koha.koha-create

# # remove koha instance first
# removekohainstance:
#   cmd.run:
#     - name: koha-remove {{ pillar['kohaname'] }}

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

createdirs:
  cmd.run:
    - name: koha-create-dirs {{ pillar['kohaname'] }}

recreate_tarball:
  cmd.run:
    - name: tar -C / -xf /tmp/{{ pillar['kohaname'] }}-2013-10-22.tar.gz
    - file: /tmp/{{ pillar['kohaname'] }}-2013-10-22.tar.gz

recreate_mysql:
  cmd.run:
    - name: zcat /tmp/{{ pillar['kohaname'] }}-2013-10-22.sql.gz | koha-mysql {{ pillar['kohaname'] }}
    - require: 
      - cmd: createdirs
      - cmd: recreate_tarball
      - file: /tmp/{{ pillar['kohaname'] }}-2013-10-22.sql.gz
