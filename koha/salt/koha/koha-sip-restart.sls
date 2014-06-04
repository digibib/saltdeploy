########
# KOHA SIP2 RESTART
########

/etc/koha/sites/{{ pillar['koha']['instance'] }}/SIPconfig.xml:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/SIP2/SIPconfig.xml
    - user: {{ pillar['koha']['instance'] }}-koha
    - mode: 640
    - template: jinja
    - context:
      sip_workers: {{ pillar['sip']['workers'] }}
      sip_host: {{ pillar['sip']['host'] }}
      sip_port: {{ pillar['sip']['port'] }}
      autouser1: {{ pillar['sip']['autouser1'] }}
      autopass1: {{ pillar['sip']['autopass1'] }}

# /etc/sysctl.conf:
#   file.append:
#     - text: 
#       - 'local6.*    -/var/log/sip2.log'
stop_sip:
  cmd.run:
    - name: koha-stop-sip {{ pillar['koha']['instance'] }}

restart_sip:
  cmd.run:
    - name: sleep 3 ; koha-start-sip {{ pillar['koha']['instance'] }}
    - require:
      - file: /etc/koha/sites/{{ pillar['koha']['instance'] }}/SIPconfig.xml
      - cmd: stop_sip
