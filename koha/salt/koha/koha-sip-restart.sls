########
# KOHA SIP2 ENABLE
########

/etc/koha/sites/{{ pillar['kohaname'] }}/SIPconfig.xml:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/SIP2/SIPconfig.xml
    - template: jinja
    - context:
      sip_host: {{ pillar['sip_host'] }}
      sip_port: {{ pillar['sip_port'] }}
      autouser1: {{ pillar['autouser1'] }}
      autopass1: {{ pillar['autopass1'] }}

# /etc/sysctl.conf:
#   file.append:
#     - text: 
#       - 'local6.*    -/var/log/sip2.log'
stop_sip:
  cmd.run:
    - name: koha-stop-sip {{ pillar['kohaname'] }}

restart_sip:
  cmd.run:
    - name: koha-start-sip {{ pillar['kohaname'] }}
    - require:
      - file: /etc/koha/sites/{{ pillar['kohaname'] }}/SIPconfig.xml
      - cmd: stop_sip
