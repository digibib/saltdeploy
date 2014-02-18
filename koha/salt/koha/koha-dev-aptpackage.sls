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

# pull branch - needs to be done manually, as there WILL be merge conflicts
# gitpull:
#   git.latest:
#     - rev: origindeichman/deichman-build
#     - name: https://github.com/digibib/koha-work
#     - target: /usr/local/src/kohaclone
#     - user: {{ pillar['kohaname'] }}-koha
#     - require:
#       - git: add_deichman_origin

########
# BUILD
########

/vagrant/debian:
  file.directory:
    - require:
      - pkg: installpkgs

increase_version:
  cmd.run:
    - name: printf %03d $[$(cat /vagrant/debian/.version) + 1] > /vagrant/debian/.version
    - cwd: /vagrant/debian

build_packages:
  cmd.run:
    - cwd: /usr/local/src/kohaclone/debian
    - name: ./build-git-snapshot -r /vagrant/debian --distribution squeeze -v 3.141-$(cat /vagrant/debian/.version)~git -d
    - require:
      - cmd: increase_version

