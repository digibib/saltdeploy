########
# MARC2RDF SETUP
########

https://github.com/digibib/marc2rdf:
  git.latest:
    - rev: master
    - target: /usr/local/src/marc2rdf

/usr/local/src/marc2rdf/settings.json:
  file.managed:
    - source: salt://files/marc2rdf_settings.json
    - stateful: True