##########
# KOHA IMPORT ALL STATE
# NB! TAKES A LOT OF TIME
##########

include:
  - koha-create

# marcxml file with all records and items
/home/vagrant/all_eximport.xml:
  file.managed:
    - source: {{ opts['filerepo'] }}/all_eximport.xml
    - source_hash: md5=fd02c84095dced5c57897b8794f13a7d  

import_all:
  cmd.run:
    - name: KOHA_CONF=/etc/koha/sites/{{ opts['kohaname'] }}/koha-conf.xml perl -I /usr/share/koha/lib/ /usr/share/koha/bin/migration_tools/bulkmarcimport.pl -m marcxml -file /home/vagrant/all_eximport.xml
    - user: {{ opts['kohaname'] }}-koha
    - require:
      - file: /home/vagrant/all_eximport.xml
      - cmd: createkohadb

rebuildzebra:
  cmd.run:
    - name: sudo koha-rebuild-zebra --full --quiet {{ opts['kohaname'] }}
    - watch: 
      - cmd: import_all