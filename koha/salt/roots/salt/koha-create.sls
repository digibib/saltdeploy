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

# make sure instance config has right permissions
/etc/koha/sites/{{ opts['kohaname'] }}:
  file.directory:
    - group: {{ opts['kohaname'] }}-koha
    - user: {{ opts['kohaname'] }}-koha
    - recurse: 
      - group
      - user
    - watch:
      - file: /etc/koha/sites/{{ opts['kohaname'] }}/zebra-biblios.cfg
      - file: /etc/koha/sites/{{ opts['kohaname'] }}/koha-conf.xml

# make sure instance index has right permissions
/var/lib/koha/{{ opts['kohaname'] }}:
  file.directory:
    - group: {{ opts['kohaname'] }}-koha
    - user: {{ opts['kohaname'] }}-koha
    - recurse: 
      - group
      - user
    - watch:
      - file: /etc/koha/sites/{{ opts['kohaname'] }}/zebra-biblios.cfg
      - file: /etc/koha/sites/{{ opts['kohaname'] }}/koha-conf.xml