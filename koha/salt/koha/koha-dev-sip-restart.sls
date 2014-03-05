########
# KOHA DEV RESTART SIP
########
# needs to stop SIP
include:
  - koha.koha-sip-stop

stop_devSIP:
  cmd.run:
    - user: {{ pillar['kohaname'] }}-koha
    - name: "screen -S kohadev-sip -X quit ; ps aux | grep IC4/SIP | grep -v grep | kill `awk '{print $2}'`"

start_devSIP:
  cmd.run:
    - cwd: /usr/local/src/kohaclone
    - user: {{ pillar['kohaname'] }}-koha
    - name: screen -dmS kohadev-sip sh -c 'cd /usr/local/src/kohaclone ; KOHA_CONF=/etc/koha/sites/{{ pillar['kohaname'] }}/koha-conf.xml perl -IC4/SIP -MILS C4/SIP/SIPServer.pm /etc/koha/sites/knakk/SIPconfig.xml ; exec bash'
