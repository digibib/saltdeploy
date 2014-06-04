########
# KOHA DISABLE DEV
########

disable_dev:
  cmd.run:
    - name: sudo a2dissite {{ pillar['koha']['instance'] }}-dev

########
# KOHA GITIFY
########

https://github.com/mkfifo/koha-gitify:
  git.latest:
    - target: /usr/local/src/koha-gitify

/etc/koha/apache-shared.conf:
  file.replace:
    - pattern: \/usr\/local\/src\/kohaclone
    - repl: /usr/share/koha/lib
    - require:
      - cmd: disable_dev

enable_prod:
  cmd.run:
    - name: sudo a2ensite {{ pillar['koha']['instance'] }}


apache2:
  service:
    - running
    - watch:
      - file: /etc/koha/apache-shared.conf
      - cmd: enable_prod

