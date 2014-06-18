########
# KOHA DEV RESTART SIP
########
# needs to stop SIP
include:
  - koha.koha-sip-stop

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

stop_devSIP:
  cmd.run:
    - user: {{ pillar['koha']['instance'] }}-koha
    - name: "screen -S kohadev-sip -X quit ; ps aux | grep IC4/SIP | grep -v grep | kill `awk '{print $2}'`"

start_devSIP:
  cmd.run:
    - cwd: /usr/local/src/kohaclone
    - user: {{ pillar['koha']['instance'] }}-koha
    - name: screen -dmS kohadev-sip sh -c 'cd /usr/local/src/kohaclone ; KOHA_CONF=/etc/koha/sites/{{ pillar['koha']['instance'] }}/koha-conf.xml perl -IC4/SIP -MILS C4/SIP/SIPServer.pm /etc/koha/sites/knakk/SIPconfig.xml ; exec bash'
