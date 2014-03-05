########
# KOHA DEV SIP2 STOP
########

stop_devsip:
  cmd.run:
    - name: kill $(cat /tmp/kohadev-sip.pid) && rm /tmp/kohadev-sip.pid
