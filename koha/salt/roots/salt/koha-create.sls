##########
# KOHA CREATE STATE
# ONLY FOR NEW BASE!
##########
include:
  - koha-files

createkohadb:
  cmd.run:
    - name: sudo koha-create --create-db {{ opts['kohaname'] }}
    - unless: test $(id -u {{ opts['kohaname'] }}-koha)

# increase memory limits on zebra index
/etc/koha/sites/{{ opts['kohaname'] }}/zebra-biblios.cfg:
  file.managed:
    - group: {{ opts['kohaname'] }}-koha
    - watch:
      - cmd: createkohadb
    - replace:
      - name: /etc/koha/sites/{{ opts['kohaname'] }}/zebra-biblios.cfg
      - pattern: biblios\/([register|shadow]):.+$
      - repl: biblios\/\1:100G
      - require:
        - cmd: createkohadb
