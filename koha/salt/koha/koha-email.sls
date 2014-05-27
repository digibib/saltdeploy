########
# KOHA FAKEEMAIL STATE
########

/etc/nullmailer/remotes:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/smtp-fake.conf
    - template: jinja

# Write unbuffered smtpd debugging to file
fakesmtp:
  cmd.run:
    - name: python -u -m smtpd -n -c DebuggingServer localhost:25 >> /tmp/fakesmtp.log
    - require: 
      - file: /etc/nullmailer/remotes

enable_mail:
  cmd.run:
    - name: koha-email-enable {{ pillar['kohaname'] }}
    - require: 
      - file: /etc/nullmailer/remotes

run_mailqueue:
  cmd.run:
    - name: koha-foreach --enabled --email /usr/share/koha/bin/cronjobs/process_message_queue.pl
    - require:
      - cmd: fakesmtp