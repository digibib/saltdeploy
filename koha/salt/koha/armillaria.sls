##########
# SALT STATE FOR ARMILLARIA
# DEPS: VIRTUOSO + ELASTICSEARCH
##########

include:
  - .elasticsearch
  - .virtuoso

armillaria_pkgs:
  pkg.latest:
    - pkgs:  
      - golang
      - git
      - python-software-properties

armillaria-user:
  user.present:
    - name: armillaria

{{ pillar['armillaria']['installdir'] }}:
  file.directory:
    - user: armillaria
    - makedirs: True
    - recurse:
      - user

# ARMILLARIA repo
https://github.com/digibib/armillaria:
  git.latest:
    - target: {{ pillar['armillaria']['installdir'] }}
    - rev: master
    - user: armillaria

{{ pillar['armillaria']['installdir'] }}/data/config.json:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/armillaria.json.tmpl
    - template: jinja    
    - require:
      - git: https://github.com/digibib/armillaria

build_armillaria:
  cmd.run:
    - cwd: {{ pillar['armillaria']['installdir'] }}
    - name: GOPATH=/usr/share/go make build
    - require:
      - git: https://github.com/digibib/armillaria

/etc/init/armillaria.conf:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/armillaria.conf
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
