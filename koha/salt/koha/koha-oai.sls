########
# KOHA OAI-PMH and MARC2RDF STATE
########

# rebuild OAI sets
rebuild_oai_sets:
  cmd.run:
    - name:  KOHA_CONF=/etc/koha/sites/{{ pillar['koha']['instance'] }}/koha-conf.xml perl -I /usr/share/koha/lib/ /usr/share/koha/bin/migration_tools/build_oai_sets.pl
    - user: {{ pillar['koha']['instance'] }}-koha
