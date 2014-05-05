##########
# KOHA IMPORT ALL STATE
# NB! TAKES A LOT OF TIME
##########

include:
  - koha.koha-create

# marcxml file with all records and items
/tmp/all_eximport.xml:
  file.managed:
    - source: {{ pillar['filerepo'] }}/all_eximport.xml
    - source_hash: md5=2a0033bb9328f3761e12c1c705883288

import_all:
  cmd.run:
    - name: KOHA_CONF=/etc/koha/sites/{{ pillar['kohaname'] }}/koha-conf.xml perl -I /usr/share/koha/lib/ /usr/share/koha/bin/migration_tools/bulkmarcimport.pl -m marcxml -file /tmp/all_eximport.xml
    - user: {{ pillar['kohaname'] }}-koha
    - require:
      - file: /tmp/all_eximport.xml
      - cmd: createkohadb

rebuildzebra:
  cmd.run:
    - name: koha-rebuild-zebra --full --quiet {{ pillar['kohaname'] }}
    - watch: 
      - cmd: import_all