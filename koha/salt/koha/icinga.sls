########
# ICINGA2 SETUP
########

icingapkgs:
  pkg.latest:
    - pkgs:
      - icinga2
      # - icinga2-ido-mysql
      - graphite-carbon
      # - python-pip
      - libapache2-mod-wsgi
      - graphite-web

# Icinga web disabled until further need
# icinga-web:
#   pkg.latest:
#     - require:
#       - pkg: icingapkgs

icingarepo:
  pkgrepo.managed:
    - humanname: Icinga 2 debian repo
    - name: deb http://packages.icinga.org/ubuntu icinga-raring main
    - dist: icinga-raring
    - key_url: http://packages.icinga.org/icinga.key
    - file: /etc/apt/sources.list.d/icinga2.list
    - require_in:
      - pkg: icingapkgs

icingaplugins:
  cmd.run:
    - name: for plug in graphite livestatus perfdata statusdata compatlog ; do icinga2-enable-feature $plug ; done
    - require:
      - pkg: icingapkgs
      - service: carbon-cache

icinga2:
  service:
    - running
    - watch:
      - cmd: icingaplugins

########
# GRAPHITE SETUP
########

/etc/default/graphite-carbon:
  file.replace:
    - pattern: "false"
    - repl: "true"

carbon-cache:
  service:
    - running
    - watch:
      - file: /etc/default/graphite-carbon
      - file: /var/lib/graphite/graphite.db

/var/lib/graphite/graphite.db:
  file.managed:
    - group: _graphite
    - mode: 664

graphite-web-db:
  cmd.run:
    - name: python /usr/share/pyshared/graphite/manage.py syncdb --noinput
    - require:
      - file: /var/lib/graphite/graphite.db

/etc/apache2/sites-enabled/apache2-graphite.conf:
  file.symlink:
    - target: /usr/share/graphite-web/apache2-graphite.conf

apache2:
  service:
    - running
    - watch:
      - file: /var/lib/graphite/graphite.db
      - file: /etc/apache2/sites-enabled/apache2-graphite.conf

# graphite-web:
#   pip.installed:
#     - require:
#       - pkg: icingapkgs

########
# NAGIOS PLUGINS
# https://github.com/monitoring-plugins
########

nagiospkgs:
  pkg.latest:
    - pkgs:
      - nagios-plugins

########
# THRUK
########

# thrukpkgs:
#   pkg.latest:
#     - skip_verify: True
#     - pkgs:
#       - thruk
#       - mk-livestatus

# thrukrepo:
#   pkgrepo.managed:
#     - humanname: Thruk webmonitoring debian repo
#     - name: deb http://labs.consol.de/repo/stable/ubuntu raring main
#     - dist: raring
#     # - keyserver: keys.gnupg.net
#     # - keyid: F8C1CA08A57B9ED7
#     - file: /etc/apt/sources.list.d/thruk.list
#     - require_in:
#       - pkg: thruk
