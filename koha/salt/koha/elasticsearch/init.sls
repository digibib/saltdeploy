##########
# SALT STATE FOR ELASTICSEARCH
##########

elasticsearch_pkgs:
  pkg.installed:
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

/etc/default/elasticsearch:
  file.managed:
    - source: {{ pillar['elasticsearchfiles'] }}/elasticsearch.defaults.tmpl
    - template: jinja
    - require_in:
      - pkg: elasticsearch_pkg

/etc/init/elasticsearch.conf:
  file.managed:
    - source: {{ pillar['elasticsearchfiles'] }}/elasticsearch.conf
    - template: jinja
    - require_in:
      - pkg: elasticsearch_pkg

elasticsearch_pkg:
  pkg.installed:
    - pkgs:
      - elasticsearch

##########
# ELASTICSEARCH PLUGINS
##########

bigdesk:
  cmd.run:
    - cwd: /usr/share/elasticsearch/bin
    - name: ./plugin -install lukas-vlcek/bigdesk
    - unless: test -d /usr/share/elasticsearch/plugins/bigdesk
    - require:
      - pkg: elasticsearch_pkg

head:
  cmd.run:
    - cwd: /usr/share/elasticsearch/bin
    - name: ./plugin -install mobz/elasticsearch-head
    - unless: test -d /usr/share/elasticsearch/plugins/head
    - require:
      - pkg: elasticsearch_pkg

# SHIT IS NOT WORKING!
# rdf_river:
#   cmd.run:
#     - cwd: /usr/share/elasticsearch/bin
#     - name: ./plugin --url https://github.com/eea/eea.elasticsearch.river.rdf/raw/master/target/releases/eea-rdf-river-plugin-1.1.zip --install eea-rdf-river-1.1
#     - unless: test -d /usr/share/elasticsearch/plugins/eea-rdf-river-1.1
#     - require:
#       - pkg: elasticsearch_pkg

browser:
  cmd.run:
    - cwd: /usr/share/elasticsearch/bin
    - name: ./plugin -install OlegKunitsyn/elasticsearch-browser
    - unless: test -d /usr/share/elasticsearch/plugins/browser
    - require:
      - pkg: elasticsearch_pkg

##########
# ELASTICSEARCH SERVICE
##########

elasticsearch:
  service.running:
    - require:
      - pkg: elasticsearch_pkg
    - watch:
      - file: /etc/init/elasticsearch.conf
      - file: /etc/default/elasticsearch
