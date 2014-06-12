##########
# KOHA DEFAULTS STATE
##########

/etc/koha/koha-sites.conf:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/koha-sites.conf
    - template: jinja
    - context:
      ServerName: {{ pillar['koha']['instance'] }}

/etc/perl/XML/SAX/ParserDetails.ini:
  file.replace:
    - pattern: \[XML::SAX::PurePerl\]
    - repl: '[XML::LibXML::SAX::Parser]'

/etc/koha/passwd:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/passwd
    - mode: 0600
    - template: jinja
    - context:
      ServerName: {{ pillar['koha']['instance'] }}

# # defaults file with libraries and item types
# /tmp/defaults.sql.gz:
#   file.managed:
#     - source: {{ pillar['saltfiles'] }}/defaults.sql.gz

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

# disable zebra rebuild cronjob
disable_zebracron:
  file.comment:
    - name: /etc/cron.d/koha-common
    - regex: ^\*.+koha-rebuild-zebra
