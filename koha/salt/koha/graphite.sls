########
# GRAPHITE SETUP
########

/etc/default/graphite-carbon:
  file.replace:
    - pattern: "false"
    - repl: "true"

/var/lib/graphite/graphite.db:
  file.managed:
    - group: _graphite
    - mode: 664

enable-graphite:
  cmd.run:
    - name: icinga2-enable-feature graphite

carbon-cache:
  service:
    - running
    - watch:
      - file: /etc/default/graphite-carbon
      - file: /var/lib/graphite/graphite.db
      - cmd: enable-graphite

# initiate graphite-web sqlite database
graphite-web-db:
  cmd.run:
    - name: python /usr/share/pyshared/graphite/manage.py syncdb --noinput
    - require:
      - file: /var/lib/graphite/graphite.db

# enable graphite-web in apache
/etc/apache2/sites-enabled/apache2-graphite.conf:
  file.symlink:
    - target: /usr/share/graphite-web/apache2-graphite.conf

apache2:
  service:
    - running
    - watch:
      - file: /var/lib/graphite/graphite.db
      - file: /etc/apache2/sites-enabled/apache2-graphite.conf

# python pip installer of graphite-web (DISABLED)
# graphite-web:
#   pip.installed:
#     - require:
#       - pkg: icingapkgs
