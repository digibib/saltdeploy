##########
# SALT STATE FOR ARMILLARIA
# DEPS: VIRTUOSO + ELASTICSEARCH
##########

include:
  - koha.elasticsearch
  - koha.virtuoso

armillaria_pkgs:
  pkg.latest:
    - pkgs:  
      - golang
      - git
      - python-software-properties

armillaria-user:
  user.present:
    - name: jenkins
    - shell: /bin/bash

{{ pillar['armillaria']['installdir'] }}:
  file.directory:
    - user: jenkins
    - makedirs: True
    - recurse:
      - user

# ARMILLARIA repo
https://github.com/digibib/armillaria:
  git.latest:
    - target: {{ pillar['armillaria']['installdir'] }}
    - rev: master
    - user: jenkins

{{ pillar['armillaria']['installdir'] }}/data/config.json:
  file.managed:
    - source: {{ pillar['armillaria']['saltfiles'] }}/armillaria.json.tmpl
    - template: jinja    
    - require:
      - git: https://github.com/digibib/armillaria

armillaria_deps:
  cmd.run:
    - cwd: {{ pillar['armillaria']['installdir'] }}
    - name: GOPATH=/usr/share/go make deps
    - unless: test -d /usr/lib/go/src/pkg/github.com/julienschmidt/httprouter
    - require:
      - git: https://github.com/digibib/armillaria

build_armillaria:
  cmd.run:
    - cwd: {{ pillar['armillaria']['installdir'] }}
    - name: GOPATH=/usr/share/go make build
    - require:
      - cmd: armillaria_deps
      - git: https://github.com/digibib/armillaria

/etc/init/armillaria.conf:
  file.managed:
    - source: {{ pillar['armillaria']['saltfiles'] }}/armillaria.conf
    - template: jinja
    - require:
      - cmd: build_armillaria

armillaria:
  service.running:
    - require: 
      - file: /etc/init/armillaria.conf
    - watch: 
      - cmd: build_armillaria

make_indexes:
  cmd.run:
    - cwd: {{ pillar['armillaria']['installdir'] }}
    - name: GOPATH=/usr/share/go make indexes
    - require:
      - service: elasticsearch

make_mappings:
  cmd.run:
    - cwd: {{ pillar['armillaria']['installdir'] }}
    - name: GOPATH=/usr/share/go make mappings
    - require:
      - service: elasticsearch
