##########
# KOHA IMPORT 15000_eximport STATE
##########

include:
  - koha-create

# marcxml file with 15000 records and items
/home/vagrant/15000_eximport.xml:
  file.managed:
    - source: {{ opts['filerepo'] }}/15000_eximport.xml
    - source_hash: md5=c18b2c01d143a93a7ecdb608169bab08  

import15000ex:
  cmd.run:
    - name: KOHA_CONF=/etc/koha/sites/{{ opts['kohaname'] }}/koha-conf.xml perl -I /usr/share/koha/lib/ /usr/share/koha/bin/migration_tools/bulkmarcimport.pl -m marcxml -file /home/vagrant/15000_eximport.xml
    - user: {{ opts['kohaname'] }}-koha
    - require:
      - file: /home/vagrant/15000_eximport.xml
      - cmd: createkohadb

rebuildzebra:
  cmd.run:
    - name: sudo koha-rebuild-zebra --full --quiet {{ opts['kohaname'] }}
    - watch: 
      - cmd: import15000ex