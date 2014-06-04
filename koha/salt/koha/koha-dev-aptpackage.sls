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

# pbuilder_create:
#   cmd.run:
#     - cwd: /usr/local/src/kohaclone
#     - name: pbuilder create --distribution squeeze --mirror ftp://ftp.debian.org/debian/ --debootstrapopts "--keyring=/usr/share/keyrings/debian-archive-keyring.gpg" 

pbuilder_update:
  cmd.run:
    - name: pbuilder update

# pbuilder_build:
#   cmd.run:
#     - name: pbuilder build whatever.dsc

# Deichmans Build from specific Gitbranch 
# koha dev mirror - synced from master

########
# KOHA GIT AND LOCAL BRANCH
########

# http://repo.or.cz/r/koha.git:
#   git.latest:
#     - rev: master
#     - target: /usr/local/src/kohaclone
#     - user: {{ pillar['koha']['instance'] }}-koha

# add deichman as origin branch
# add_deichman_origin:
#   cmd.run:
#     - name: git remote add origindeichman https://github.com/digibib/koha-work
#     - cwd: /usr/local/src/kohaclone
#     - user: {{ pillar['koha']['instance'] }}-koha
#     - require:
#       - git: http://repo.or.cz/r/koha.git

# Make sure nothing is preventing checkout and pull
clear_uncommitted:
  cmd.run:
    - name: git stash
    - cwd: /usr/local/src/kohaclone
    - user: {{ pillar['koha']['instance'] }}-koha

checkout_build_branch:
  cmd.run:
    - name: git checkout origindeichman/deichman-build
    - cwd: /usr/local/src/kohaclone
    - user: {{ pillar['koha']['instance'] }}-koha
    - require:
      - cmd: clear_uncommitted

gitpull:
  cmd.run:
    - name: git pull origindeichman deichman-build
    - cwd: /usr/local/src/kohaclone
    - user: {{ pillar['koha']['instance'] }}-koha
    - require:
      - cmd: checkout_build_branch

# pull branch - needs to be done manually, as there WILL be merge conflicts
# gitpull:
#   git.latest:
#     - rev: origindeichman/deichman-build
#     - name: https://github.com/digibib/koha-work
#     - target: /usr/local/src/kohaclone
#     - user: {{ pillar['koha']['instance'] }}-koha
#     - require:
#       - git: add_deichman_origin

########
# BUILD
########

/vagrant/debian:
  file.directory:
    - require:
      - pkg: installpkgs

clear_old_packages:
  cmd.run:
    - name: rm -f /vagrant/debian/koha*

increase_version:
  cmd.run:
    - name: echo $[$(cat /vagrant/debian/.version) + 1] > /vagrant/debian/.version
    - cwd: /vagrant/debian
    - require:
      - cmd: clear_old_packages

build_packages:
  cmd.run:
    - cwd: /usr/local/src/kohaclone
    - name: ./debian/build-git-snapshot -r /vagrant/debian --distribution squeeze -v 3.141-$(printf %03d $(cat /vagrant/debian/.version))~git -d
    - require:
      - cmd: increase_version

