########
# KOHA DUMMY PATRON DATA
########
https://github.com/digibib/LibrioTools:
  git.latest:
    - rev: master
    - target: /tmp/LibrioTools

/tmp/LibrioTools/sim/patrons.yaml:
  file.managed:
    - source: salt://files/patrons.yaml
    - stateful: True

createpatrons:
  cmd.run:
    - name: sudo koha-shell knakk -c "perl patrons.pl -n {{ opts['dummypatrons'] }} -c patrons.yaml"
    - cwd: /tmp/LibrioTools/sim
    - require:
      - file: /tmp/LibrioTools/sim/patrons.yaml
      - git: https://github.com/digibib/LibrioTools
    - watch: 
      - file: /tmp/LibrioTools/sim/patrons.yaml