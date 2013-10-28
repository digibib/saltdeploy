########
# MARC2RDF SETUP
########

marc2rdfpkgs:
  pkg.latest:
    - pkgs:
      - ruby1.9.3
      - ruby1.9.1-dev
      - libxml2-dev 
      - libxslt1-dev 
      - zlib1g-dev
      - bundler
      - virtuoso-minimal

########
# UPSTART FILES
########

/etc/init/marc2rdf.conf:
  file.managed:
    - source: salt://files/marc2rdf/marc2rdf.conf
    - template: jinja
    - context:
      User: {{ opts['kohaname'] }}-koha
    - require:
      - file: /etc/init/marc2rdf-app.conf
      - file: /etc/init/marc2rdf-scheduler.conf
      - file: /etc/init/marc2rdf-load_schedules.conf

/etc/init/marc2rdf-app.conf:
  file.managed:
    - source: salt://files/marc2rdf/marc2rdf-app.conf
    - template: jinja
    - context:
      Port: 3000
      User: {{ opts['kohaname'] }}-koha

/etc/init/marc2rdf-scheduler.conf:
  file.managed:
    - source: salt://files/marc2rdf/marc2rdf-scheduler.conf
    - template: jinja
    - context:
      Port: 3100
      User: {{ opts['kohaname'] }}-koha

/etc/init/marc2rdf-load_schedules.conf:
  file.managed:
    - source: salt://files/marc2rdf/marc2rdf-load_schedules.conf
    - template: jinja
    - context:
      Port: 3200
      User: {{ opts['kohaname'] }}-koha

########
# VIRTUOSO
########

/etc/init/virtuoso.conf:
  file.managed:
    - source: salt://files/virtuoso/virtuoso.conf
    - template: jinja
    - context:
      User: {{ opts['kohaname'] }}-koha

/data/virtuoso/virtuoso.ini:
  file.managed:
    - source: salt://files/virtuoso/virtuoso.ini.minimal
    - require: 
      - pkg: marc2rdfpkgs

########
# MARC2RDF
########

https://github.com/digibib/marc2rdf:
  git.latest:
    - rev: master
    - target: /usr/local/src/marc2rdf

/usr/local/src/marc2rdf/config/settings.json:
  file.managed:
    - source: salt://files/marc2rdf/marc2rdf_settings.json
    - stateful: True
    - require:
      - git: https://github.com/digibib/marc2rdf

/usr/local/src/marc2rdf/db/libraries.json:
  file.managed:
    - source: salt://files/marc2rdf/libraries.json
    - require:
      - git: https://github.com/digibib/marc2rdf

/usr/local/src/marc2rdf/db/mappings.json:
  file.managed:
    - source: salt://files/marc2rdf/mappings.json
    - require:
      - git: https://github.com/digibib/marc2rdf

bundle_marc2rdf: 
  cmd.run:
    - cwd: /usr/local/src/marc2rdf
    - name: bundle install
    - require:
      - pkg: marc2rdfpkgs

/usr/local/src/marc2rdf:
  file.directory:
    - user: {{ opts['kohaname'] }}-koha
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
    - watch:
      - git: https://github.com/digibib/marc2rdf

virtuoso:
  service.running:
    - enable: True
    - require:
      - file: /data/virtuoso/virtuoso.ini
      - file: /etc/init/virtuoso.conf