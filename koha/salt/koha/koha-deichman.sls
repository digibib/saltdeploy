##########
# KOHA LOCAL DEICHMAN STATE
##########

# db modifications
/tmp/custom.sql:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/custom.sql
    - template: jinja

# sysprefs
/tmp/sysprefs.sql:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/sysprefs.sql
    - template: jinja

custom_sql:
  cmd.run:
    - name: koha-mysql {{ pillar['koha']['instance'] }} < /tmp/custom.sql

custom_sysprefs:
  cmd.run:
    - name: koha-mysql {{ pillar['koha']['instance'] }} < /tmp/sysprefs.sql

# disable zebra rebuild cronjob
disable_zebracron:
  file.comment:
    - name: /etc/cron.d/koha-common
    - regex: ^\*.+koha-rebuild-zebra

# increase memory limits on zebra index
increase_memory_limits_zebra:
  file.replace:
    - name: /etc/koha/sites/{{ pillar['koha']['instance'] }}/zebra-biblios.cfg
    - pattern: biblios\/(register|shadow):.+$
    - repl: biblios/\1:100G

# Use Ubuntu libxml, faster XML parsing
/etc/perl/XML/SAX/ParserDetails.ini:
  file.replace:
    - pattern: \[XML::SAX::PurePerl\]
    - repl: '[XML::LibXML::SAX::Parser]'

# make sure instance config has right permissions
# /etc/koha/sites/{{ pillar['koha']['instance'] }}:
#   file.directory:
#     - group: {{ pillar['koha']['instance'] }}-koha
#     - user: {{ pillar['koha']['instance'] }}-koha
#     - recurse: 
#       - group
#       - user
#     - watch:
#       - file: /etc/koha/sites/{{ pillar['koha']['instance'] }}/zebra-biblios.cfg
#       - file: /etc/koha/sites/{{ pillar['koha']['instance'] }}/koha-conf.xml

# make sure instance index has right permissions
# /var/lib/koha/{{ pillar['koha']['instance'] }}:
#   file.directory:
#     - group: {{ pillar['koha']['instance'] }}-koha
#     - user: {{ pillar['koha']['instance'] }}-koha
#     - recurse: 
#       - group
#       - user
#     - watch:
#       - file: /etc/koha/sites/{{ pillar['koha']['instance'] }}/zebra-biblios.cfg
#       - file: /etc/koha/sites/{{ pillar['koha']['instance'] }}/koha-conf.xml

