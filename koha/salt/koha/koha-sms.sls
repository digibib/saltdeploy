########
# KOHA SMS STATE
########

/usr/share/perl5/SMS/Send/NO/HTTP.pm:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/HTTP.pm
    - makedirs: True
    - template: jinja

