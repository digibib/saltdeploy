########
# KOHA SIP2 STOP
########

stop_sip:
  cmd.run:
    - name: koha-stop-sip {{ pillar['kohaname'] }}