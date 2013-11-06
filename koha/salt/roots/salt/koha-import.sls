##########
# KOHA IMPORT 500ex STATE
##########

include:
  - koha-create

# marcxml file with 500 records and items
/tmp/500_eximport.xml:
  file.managed:
    - source: {{ pillar['filerepo'] }}/500_eximport.xml
    - source_hash: md5=8b1be91aaf4130da47e32c0c87ca8e43  

import500ex:
  cmd.run:
    - name: sudo koha-shell knakk -c "perl -I /usr/share/koha/lib/ /usr/share/koha/bin/migration_tools/bulkmarcimport.pl -m marcxml -file /tmp/500_eximport.xml"
    - user: {{ pillar['kohaname'] }}-koha
    - require:
      - file: /tmp/500_eximport.xml:
      - cmd: createkohadb

rebuildzebra:
  cmd.run:
    - name: sudo koha-rebuild-zebra --full {{ pillar['kohaname'] }}
    - watch: 
      - cmd: import500ex