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
    - source_hash: md5=1924ba3252731d0a4271ca0c2d4162de

import_all:
  cmd.run:
    - name: KOHA_CONF=/etc/koha/sites/{{ pillar['koha']['instance'] }}/koha-conf.xml perl -I /usr/share/koha/lib/ /usr/share/koha/bin/migration_tools/bulkmarcimport.pl -m marcxml -d -file /tmp/all_eximport.xml -g 001
    - user: {{ pillar['koha']['instance'] }}-koha
    - require:
      - file: /tmp/all_eximport.xml
      - cmd: createkohadb

rebuildzebra:
  cmd.run:
    - name: koha-rebuild-zebra --full --quiet {{ pillar['koha']['instance'] }}
    - watch: 
      - cmd: import_all