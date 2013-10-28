##########
# KOHA CREATE STATE
# ONLY FOR NEW BASE!
##########
include:
  - koha-defaults

createkohadb:
  cmd.run:
    - name: sudo koha-create --create-db {{ opts['kohaname'] }}
    - unless: test $(id -u {{ opts['kohaname'] }}-koha)

# increase memory limits on zebra index
/etc/koha/sites/{{ opts['kohaname'] }}/zebra-biblios.cfg:
  file.replace:
    - name: /etc/koha/sites/{{ opts['kohaname'] }}/zebra-biblios.cfg
    - pattern: biblios\/(register|shadow):.+$
    - repl: biblios/\1:100G
    - require:
      - cmd: createkohadb

# enable koha plugins
/etc/koha/sites/{{ opts['kohaname'] }}/koha-conf.xml:
  file.replace:
    - name: /etc/koha/sites/{{ opts['kohaname'] }}/koha-conf.xml
    - pattern: <enable_plugins>0
    - repl: <enable_plugins>1
    - require:
      - cmd: createkohadb

/etc/koha/sites/{{ opts['kohaname'] }}:
  file.directory:
    - group: {{ opts['kohaname'] }}-koha
    - watch:
      - file: /etc/koha/sites/{{ opts['kohaname'] }}/zebra-biblios.cfg
      - file: /etc/koha/sites/{{ opts['kohaname'] }}/koha-conf.xml