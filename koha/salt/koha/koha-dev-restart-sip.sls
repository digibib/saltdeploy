########
# KOHA DEV RESTART SIP
########
# needs to stop SIP
include:
  - koha.koha-sip-stop

startSIP:
  cmd.run:
    - cwd: /usr/local/src/kohaclone
    - user: {{ pillar['kohaname'] }}-koha
    - name: KOHA_CONF=/etc/koha/sites/{{ pillar['kohaname'] }}/koha-conf.xml perl -IC4/SIP -MILS C4/SIP/SIPServer.pm /etc/koha/sites/knakk/SIPconfig.xml & echo $! > /tmp/kohadev-sip.pid