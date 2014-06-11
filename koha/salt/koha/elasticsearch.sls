##########
# SALT STATE FOR ELASTICSEARCH
##########

elasticsearch_pkgs:
  pkg.latest:
    - pkgs:  
      - python-software-properties
      - openjdk-7-jre-headless

elasticsearch_repo:
  pkgrepo.managed:
    - humanname: elasticsearch APT Repo
    - name: deb http://packages.elasticsearch.org/elasticsearch/1.1/debian stable main
    - file: /etc/apt/sources.list.d/elasticsearch.list
    - key_url: http://packages.elasticsearch.org/GPG-KEY-elasticsearch
    - require_in:
      - pkg: elasticsearch

elasticsearch_pkg:
  pkg.latest:
    - pkgs:
      - elasticsearch

/etc/default/elasticsearch:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/elasticsearch.defaults.tmpl
    - template: jinja
    - require:
      - pkg: elasticsearch_pkgs

/etc/init/elasticsearch.conf:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/elasticsearch.conf
    - template: jinja
    - require:
      - pkg: elasticsearch_pkgs

##########
# ELASTICSEARCH PLUGINS
##########

bigdesk:
  cmd.run:
    - cwd: /usr/share/elasticsearch/bin
    - name: ./plugin -install lukas-vlcek/bigdesk
    - unless: test -d /usr/share/elasticsearch/plugins/bigdesk
    - require:
      - pkg: elasticsearch_pkgs

head:
  cmd.run:
    - cwd: /usr/share/elasticsearch/bin
    - name: ./plugin -install mobz/elasticsearch-head
    - unless: test -d /usr/share/elasticsearch/plugins/head
    - require:
      - pkg: elasticsearch_pkgs

# SHIT IS NOT WORKING!
# rdf_river:
#   cmd.run:
#     - cwd: /usr/share/elasticsearch/bin
#     - name: ./plugin --url https://github.com/eea/eea.elasticsearch.river.rdf/raw/master/target/releases/eea-rdf-river-plugin-1.1.zip --install eea-rdf-river-1.1
#     - unless: test -d /usr/share/elasticsearch/plugins/eea-rdf-river-1.1
#     - require:
#       - pkg: elasticsearch_pkgs

browser:
  cmd.run:
    - cwd: /usr/share/elasticsearch/bin
    - name: ./plugin -install OlegKunitsyn/elasticsearch-browser
    - unless: test -d /usr/share/elasticsearch/plugins/browser
    - require:
      - pkg: elasticsearch_pkgs

##########
# ELASTICSEARCH SERVICE
##########

elasticsearch:
  service.running:
    - require:
      - pkgrepo: elasticsearch_repo
    - watch:
      - file: /etc/init/elasticsearch.conf
      - file: /etc/default/elasticsearch
