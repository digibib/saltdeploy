########
# KOHA DEV PROCESS MESSAGE QUEUE
########

run_messagequeue:
  cmd.run:
  - cwd: /usr/local/src/kohaclone
  - name: KOHA_CONF=/etc/koha/sites/{{ pillar['kohaname'] }}/koha-conf.xml perl -I ./ ./misc/cronjobs/process_message_queue.pl -v
  - user: {{ pillar['kohaname'] }}-koha
