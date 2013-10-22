########
# KOHA DUMMY CIRCULATION DATA
########

https://github.com/digibib/LibrioTools:
  git.latest:
    - rev: master
    - target: /tmp/LibrioTools

/tmp/LibrioTools/sim/circulation.yaml:
  file.managed:
    - source: salt://files/circulation.yaml
    - stateful: True

# run circulation
circulatefromsep2013:
  cmd.run:
    - name: sudo KOHA_CONF=/etc/koha/sites/{{ opts['kohaname'] }}/koha-conf.xml PERL5LIB=/usr/share/koha/lib perl circ.pl -v -f 2013-09-01 -r 14 -c circulation.yaml
    - cwd: /tmp/LibrioTools/sim
    - require:
      - file: /tmp/LibrioTools/sim/circulation.yaml
      - git: https://github.com/digibib/LibrioTools
    - watch: 
      - file: /tmp/LibrioTools/sim/circulation.yaml

returnfromsep2013:
  cmd.run:
    - name: sudo KOHA_CONF=/etc/koha/sites/{{ opts['kohaname'] }}/koha-conf.xml PERL5LIB=/usr/share/koha/lib perl circ.pl -v -z -c circulation.yaml
    - cwd: /tmp/LibrioTools/sim
    - require:
      - file: /tmp/LibrioTools/sim/circulation.yaml
      - git: https://github.com/digibib/LibrioTools
    - watch: 
      - cmd: circulatefromsep2013