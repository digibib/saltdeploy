########
# KOHA DEV run updatedatabase script
########

updatedatabase:
  cmd.run:
    - cwd: /usr/local/src/kohaclone  
    - name:  KOHA_CONF=/etc/koha/sites/{{ pillar['kohaname'] }}/koha-conf.xml perl -I /usr/share/koha/lib/ ./installer/data/mysql/updatedatabase.pl
    - user: {{ pillar['kohaname'] }}-koha