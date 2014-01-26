########
# GRAPHITE RESET STATE
########

# clear carbon graphs
graphite-carbon-clean:
  cmd.run:
    - name: rm -rf /var/lib/graphite/whisper/*

# remove graphite db
purge-graphite-db:
  cmd.run:
    - name: rm -rf /var/lib/graphite/graphite.db

purge-graphite-cache:
  cmd.run:
    - name: rm -rf /var/lib/graphite/.cache

purge-graphite-index:
  cmd.run:
    - name: rm -rf /var/lib/graphite/search_index

# initiate graphite-web sqlite database
graphite-web-db:
  cmd.run:
    - name: python /usr/share/pyshared/graphite/manage.py syncdb --noinput
    - require:
      - cmd: purge-graphite-db

/var/lib/graphite/graphite.db:
  file.managed:
    - user: _graphite
    - group: _graphite
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
