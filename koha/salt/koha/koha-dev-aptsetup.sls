########
# KOHA BUILD APT-PACKAGES SETUP
########

installpkgs:
  pkg.latest:
    - pkgs:
      - debian-archive-keyring 
      - devscripts 
      - pbuilder 
      - dh-make 
      - fakeroot

########
# PBUILDER ENV (INSIDE VIRTUALBOX)
########

pbuilder_create:
  cmd.run:
    - cwd: /usr/local/src/kohaclone
    - name: pbuilder create --distribution squeeze --mirror ftp://ftp.debian.org/debian/ --debootstrapopts "--keyring=/usr/share/keyrings/debian-archive-keyring.gpg" 

pbuilder_update:
  cmd.run:
    - name: pbuilder update

pbuilder_build:
  cmd.run:
    - name: pbuilder build whatever.dsc

# Deichmans Build from specific Gitbranch 
# koha dev mirror
http://repo.or.cz/r/koha.git:
  git.latest:
    - rev: master
    - target: /usr/local/src/kohaclone
    - user: {{ pillar['kohaname'] }}-koha

# add deichman as origin branch
add_deichman_origin:
  cmd.run:
    - name: git remote add origindeichman https://github.com/digibib/koha-work
    - cwd: /usr/local/src/kohaclone
    - user: {{ pillar['kohaname'] }}-koha
    - require:
      - git: http://repo.or.cz/r/koha.git

checkout_build_branch:
  cmd.run:
    - name: git checkout origindeichman/deichman-build
    - cwd: /usr/local/src/kohaclone
    - user: {{ pillar['kohaname'] }}-koha
    - require:
      - cmd: add_deichman_origin

# pull branch
# gitpull:
#   git.latest:
#     - rev: origindeichman/deichman-build
#     - name: https://github.com/digibib/koha-work
#     - target: /usr/local/src/kohaclone
#     - user: {{ pillar['kohaname'] }}-koha
#     - require:
#       - git: add_deichman_origin

#mkdir -p ~/debian

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

