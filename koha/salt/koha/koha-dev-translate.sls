#######
# DEV CMD for updating translation and templates
#######

translate:
  cmd.run:
    - cwd: /usr/local/src/kohaclone/misc/translator
    - name: KOHA_CONF=/etc/koha/sites/{{ pillar['koha']['instance'] }}/koha-conf.xml PERL5LIB=/usr/local/src/kohaclone perl -I ./ translate install nb-NO
    - user: {{ pillar['koha']['instance'] }}-koha
