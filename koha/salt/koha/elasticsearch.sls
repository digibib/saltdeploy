##########
# SALT STATE FOR ELASTICSEARCH
##########

installpkgs:
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

elasticsearch:
  service.running:
    - require:
      - pkgrepo: elasticsearch_repo