########
# KOHA DEV PROCESS MESSAGE QUEUE
########

run_messagequeue:
  cmd.run:
  - cwd: /usr/local/src/kohaclone
  - name: KOHA_CONF=/etc/koha/sites/{{ pillar['koha']['instance'] }}/koha-conf.xml perl -I ./ ./misc/cronjobs/process_message_queue.pl -v
  - user: {{ pillar['koha']['instance'] }}-koha
