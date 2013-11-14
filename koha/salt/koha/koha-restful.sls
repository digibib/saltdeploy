##########
# KOHA REST API
##########

libcgi-application-dispatch-perl:
  pkg.latest

https://github.com/clrh/koha-restful:
  git.latest:
    - rev: master
    - target: /usr/local/src/koha-restful

/usr/share/koha/lib/Koha/REST:
  file.symlink:
    - target: /usr/local/src/koha-restful/Koha/REST

/usr/share/koha/opac/cgi-bin/opac/rest.pl:
  file.symlink:
    - target: /usr/local/src/koha-restful/opac/rest.pl

/etc/koha/sites/{{ pillar['kohaname'] }}/rest:
  file.directory:
    - user: {{ pillar['kohaname'] }}-koha
    - group: {{ pillar['kohaname'] }}-koha
    - mode: 755
    - makedirs: True

/etc/koha/sites/{{ pillar['kohaname'] }}/rest/config.yaml:
  file.managed:
    - source: "{{ pillar['saltfiles'] }}/koha-restful-config.yaml"
    - user: {{ pillar['kohaname'] }}-koha
    - group: {{ pillar['kohaname'] }}-koha    
    - require:
      - file: /etc/koha/sites/{{ pillar['kohaname'] }}/rest
