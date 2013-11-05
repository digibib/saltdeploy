##########
# KOHA IMPORT 500ex STATE
##########

include:
  - koha-create

# import defaults now done automatically in koha-create
# importdefaults:
#   cmd.run:
#     - name: zcat defaults.sql.gz | sudo koha-mysql {{ opts['kohaname'] }}
#     - require: 
#       - file: /home/vagrant/1000ex_defaults.sql.gz

# marcxml file with 500 records and items
/home/vagrant/500_eximport.xml:
  file.managed:
    - source: {{ opts['filerepo'] }}/500_eximport.xml
    - source_hash: md5=8b1be91aaf4130da47e32c0c87ca8e43  

import500ex:
  cmd.run:
    - name: KOHA_CONF=/etc/koha/sites/{{ opts['kohaname'] }}/koha-conf.xml perl -I /usr/share/koha/lib/ /usr/share/koha/bin/migration_tools/bulkmarcimport.pl -m marcxml -file /home/vagrant/500_eximport.xml
    - user: {{ opts['kohaname'] }}-koha
    - require:
      - file: /home/vagrant/500_eximport.xml
      - cmd: createkohadb

rebuildzebra:
  cmd.run:
    - name: sudo koha-rebuild-zebra --full {{ opts['kohaname'] }}
    - watch: 
      - cmd: import500ex