########
# KOHA SIP2 ENABLE
########

/etc/koha/sites/{{ pillar['kohaname'] }}/SIPconfig.xml:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/SIP2/SIPconfig.xml
    - template: jinja
    - context:
      Adminuser: {{ pillar['adminuser'] }}
      Adminpass: {{ pillar['adminpass'] }}

start_sip:
  cmd.run:
    - name: koha-start-sip {{ pillar['kohaname'] }}
    - require:
      - file: /etc/koha/sites/{{ pillar['kohaname'] }}/SIPconfig.xml
