########
# KOHA DEV SETUP
########

installpkgs:
  pkg.latest:
    - pkgs:
      - tig

masterkohabranch:
  cmd.run:
    - cwd: /usr/local/src/kohaclone
    - name: git checkout master

# koha dev mirror
http://repo.or.cz/r/koha.git:
  git.latest:
    - rev: master
    - target: /usr/local/src/kohaclone
    - user: {{ pillar['kohaname'] }}-koha
    - require:
      - cmd: masterkohabranch

/etc/apache2/sites-available/{{ pillar['kohaname'] }}-dev.conf:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/apache-dev.tmpl
    - template: jinja
    - context:
      OpacPort: 8080
      IntraPort: 8081
      ServerName: {{ pillar['kohaname'] }}
    - stateful: True

########
# KOHA BUGZILLA SETUP
########

/usr/local/bin/git-bz:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/git-bz
    - mode: 755

########
# KOHA GITIFY
########

https://github.com/mkfifo/koha-gitify:
  git.latest:
    - target: /usr/local/src/koha-gitify

gitify:
  cmd.run:
    - name: /usr/local/src/koha-gitify/koha-gitify {{ pillar['kohaname'] }} /usr/local/src/kohaclone
    - cwd: /usr/local/src/kohaclone

/var/lib/koha/{{ pillar['kohaname'] }}/.gitconfig:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/koha-tmpl/gitconfig.tmpl
    - template: jinja
    - context:
      bz_user: {{ pillar['bz_user'] }}
      bz_pass: {{ pillar['bz_pass'] }}

/etc/koha/apache-shared.conf:
  file.replace:
    - pattern: \/usr\/share\/koha\/lib
    - repl: /usr/local/src/kohaclone
    - require:
      - cmd: gitify

disable_prod:
  cmd.run:
    - name: sudo a2dissite {{ pillar['kohaname'] }}

enable_dev:
  cmd.run:
    - name: sudo a2ensite {{ pillar['kohaname'] }}-dev
    - require:
      - cmd: disable_prod

apache2:
  service:
    - running
    - watch:
      - file: /etc/koha/apache-shared.conf
      - cmd: enable_dev

