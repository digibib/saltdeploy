#######
# DEV CMD for updating translation and templates
#######

translate:
  cmd.run:
    - cwd: /usr/local/src/kohaclone/misc/translator
    - name: KOHA_CONF=/etc/koha/sites/{{ pillar['kohaname'] }}/koha-conf.xml PERL5LIB=/usr/local/src/kohaclone perl -I ./ translate update nb-NO
    - user: {{ pillar['kohaname'] }}-koha
    - require:
      - git: http://repo.or.cz/r/koha.git
