########
# KOHA DUMMY PATRON DATA
########
https://github.com/digibib/LibrioTools:
  git.latest:
    - rev: master
    - target: /usr/local/src/LibrioTools

/usr/local/src/LibrioTools/sim/patrons.yaml:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/patrons.yaml
    - stateful: True

createpatrons:
  cmd.run:
    - name: KOHA_CONF=/etc/koha/sites/{{ pillar['koha']['instance'] }}/koha-conf.xml perl -I /usr/share/koha/lib/ ./patrons.pl -n {{ pillar['dummypatrons'] }} -c patrons.yaml
    - cwd: /usr/local/src/LibrioTools/sim
    - require:
      - file: /usr/local/src/LibrioTools/sim/patrons.yaml
      - git: https://github.com/digibib/LibrioTools
    - watch: 
      - file: /usr/local/src/LibrioTools/sim/patrons.yaml