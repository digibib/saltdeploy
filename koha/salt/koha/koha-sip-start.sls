########
# KOHA SIP2 ENABLE
########

/etc/koha/sites/{{ pillar['kohaname'] }}/SIPconfig.xml:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/SIP2/SIPconfig.xml
    - template: jinja
    - context:
      Autouser1: {{ pillar['autouser1'] }}
      Autopass1: {{ pillar['autopass1'] }}

/etc/syslog.conf:
  file.append:
    - text: 
      - 'local6.*    -/var/log/sip2.log'

start_sip:
  cmd.run:
    - name: koha-start-sip {{ pillar['kohaname'] }}
    - require:
      - file: /etc/koha/sites/{{ pillar['kohaname'] }}/SIPconfig.xml
