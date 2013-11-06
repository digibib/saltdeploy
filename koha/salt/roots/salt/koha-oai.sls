########
# KOHA OAI-PMH and MARC2RDF STATE
########

# rebuild OAI sets
rebuild_oai_sets:
  cmd.run:
    - name: sudo koha-shell knakk -c "perl -I /usr/share/koha/lib/ /usr/share/koha/bin/migration_tools/build_oai_sets.pl"
    - user: {{ pillar['kohaname'] }}-koha
