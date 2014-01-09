########
# KOHA DEV SETUP
########

installpkgs:
  pkg.latest:
    - pkgs:
      - tig

# koha dev mirror
http://repo.or.cz/r/koha.git:
  git.latest:
    - rev: master
    - target: /usr/local/src/kohaclone
    - user: {{ pillar['kohaname'] }}-koha

########
# KOHA BUGZILLA SETUP
########

https://github.com/Koha-Community/git-bz.git:
  git.latest:
    - rev: fishsoup
    - target: /usr/local/src/git-bz

/usr/local/bin/git-bz:
  file.symlink:
    - target: /usr/local/src/git-bz/git-bz

########
# KOHA GITIFY
########

https://github.com/mkfifo/koha-gitify:
  git.latest:
    - target: /usr/local/src/koha-gitify

gitify:
  cmd.run:
    - name: /usr/local/src/koha-gitify {{ pillar['kohaname'] }} /usr/local/src/kohaclone
    - cwd: /usr/local/src/kohaclone

/var/lib/koha/{{ pillar['kohaname'] }}/.gitconfig:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/koha-tmpl/gitconfig.tmpl
    - template: jinja
    - context:
      bz_user: {{ pillar['bz_user'] }}
      bz_pass: {{ pillar['bz_pass'] }}
