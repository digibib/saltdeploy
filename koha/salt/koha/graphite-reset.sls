########
# GRAPHITE RESET STATE
########

# clear carbon graphs
graphite-carbon-clean:
  cmd.run:
    - name: rm -rf /var/lib/graphite/whisper/

# remove graphite db
purge-graphite-db:
  cmd.run:
    - name: rm -rf /var/lib/graphite/graphite.db

# initiate graphite-web sqlite database
graphite-web-db:
  cmd.run:
    - name: python /usr/share/pyshared/graphite/manage.py syncdb --noinput
    - require:
      - cmd: purge-graphite-db

/var/lib/graphite/graphite.db:
  file.managed:
    - group: _graphite
    - mode: 664
    - require:
      - cmd: graphite-web-db

carbon-cache:
  service:
    - running
    - watch:
      - file: /var/lib/graphite/graphite.db

apache2:
  service:
    - running
    - watch:
      - service: carbon-cache
