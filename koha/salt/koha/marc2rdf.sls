########
# MARC2RDF SETUP
########

marc2rdf_pkgs:
  pkg.latest:
    - pkgs:
      - ruby1.9.3
      - ruby1.9.1-dev
      - libxml2-dev 
      - libxslt1-dev 
      - zlib1g-dev
      - bundler
#      - virtuoso-minimal

marc2rdf-user:
  user.present:
    - name: {{ pillar['koha']['instance'] }}-marc2rdf

########
# UPSTART FILES
########

/etc/init/marc2rdf.conf:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/marc2rdf/marc2rdf.conf
    - template: jinja
    - context:
      User: {{ pillar['koha']['instance'] }}-marc2rdf
    - require:
      - file: /etc/init/marc2rdf-app.conf
      - file: /etc/init/marc2rdf-scheduler.conf
      - file: /etc/init/marc2rdf-load_schedules.conf

/etc/init/marc2rdf-app.conf:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/marc2rdf/marc2rdf-app.conf
    - template: jinja
    - context:
      Port: 3000
      User: {{ pillar['koha']['instance'] }}-marc2rdf

/etc/init/marc2rdf-scheduler.conf:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/marc2rdf/marc2rdf-scheduler.conf
    - template: jinja
    - context:
      Port: 3100
      User: {{ pillar['koha']['instance'] }}-marc2rdf

/etc/init/marc2rdf-load_schedules.conf:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/marc2rdf/marc2rdf-load_schedules.conf
    - template: jinja
    - context:
      Port: 3200
      User: {{ pillar['koha']['instance'] }}-marc2rdf

########
# MARC2RDF
########

https://github.com/digibib/marc2rdf:
  git.latest:
    - rev: master
    - target: /usr/local/src/marc2rdf

/usr/local/src/marc2rdf/config/settings.json:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/marc2rdf/marc2rdf_settings.json
    - stateful: True
    - template: jinja
    - require:
      - git: https://github.com/digibib/marc2rdf

/usr/local/src/marc2rdf/db/libraries.json:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/marc2rdf/libraries.json
    - require:
      - git: https://github.com/digibib/marc2rdf

/usr/local/src/marc2rdf/db/mappings.json:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/marc2rdf/mappings.json
    - require:
      - git: https://github.com/digibib/marc2rdf

/usr/local/src/marc2rdf/db/rules.json:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/marc2rdf/rules.json
    - require:
      - git: https://github.com/digibib/marc2rdf

bundle_marc2rdf: 
  cmd.run:
    - cwd: /usr/local/src/marc2rdf
    - name: bundle install
    - require:
      - pkg: marc2rdf_pkgs

/usr/local/src/marc2rdf:
  file.directory:
    - user: {{ pillar['koha']['instance'] }}-marc2rdf
    - recurse:
      - user

########
# SERVICES
########

marc2rdf:
  service.running:
    - enable: True
    - require:
      - file: /etc/init/marc2rdf.conf
      - file: /usr/local/src/marc2rdf/config/settings.json
      - file: /usr/local/src/marc2rdf/db/libraries.json
      - file: /usr/local/src/marc2rdf/db/mappings.json
      - file: /usr/local/src/marc2rdf/db/rules.json
    - watch:
      - git: https://github.com/digibib/marc2rdf

