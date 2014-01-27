########
# ICINGA2 SETUP (WITH GRAPHITE)
########

icingapkgs:
  pkg.latest:
    - pkgs:
      - icinga2
      # - icinga2-ido-mysql
      - graphite-carbon
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
    - name: for plug in perfdata statusdata compatlog ; do icinga2-enable-feature $plug ; done
    - require:
      - pkg: icingapkgs

########
# ICINGA2 CONFIG FILES
# /etc/icinga2/conf.d
########


# http://mathias-kettner.de/checkmk_livestatus.html#H1:LQL%20-%20The%20Livestatus%20Query%20Language
# echo -e "GET hosts\n\n" | nc 10.0.2.15 6558
/etc/icinga2/features-available/livestatus.conf:
  file.managed:
    - template: jinja
    - mode: 644
    - source: {{ pillar['saltfiles'] }}/icinga/livestatus.conf

enable-livestatus:
  cmd.run:
    - name: icinga2-enable-feature livestatus
    - require:
      - file: /etc/icinga2/features-available/livestatus.conf

/etc/icinga2/conf.d:
  file.recurse:
    - template: jinja
    - file_mode: 644
    - source: {{ pillar['saltfiles'] }}/icinga/conf.d
    - include_empty: True
    - clean: True

icinga2:
  service:
    - running
    - watch:
      - cmd: icingaplugins
      - cmd: enable-livestatus
      - file: /etc/icinga2/conf.d
      - file: /usr/lib/nagios/plugins/check_mysqld.pl
      - file: /usr/lib/nagios/plugins/check_json.pl

########
# NAGIOS PLUGINS
# https://github.com/monitoring-plugins
# installs to /usr/lib/nagios/plugins
########

nagiospkgs:
  pkg.latest:
    - pkgs:
      - nagios-plugins
      - libjson-perl
      - libnagios-plugin-perl

/usr/lib/nagios/plugins/check_mysqld.pl:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/icinga/plugins/check_mysqld.pl
    - mode: 755
    - stateful: True
    - require:
      - pkg: nagiospkgs

/usr/lib/nagios/plugins/check_json.pl:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/icinga/plugins/check_json.pl
    - mode: 755
    - stateful: True
    - require:
      - pkg: nagiospkgs

/usr/lib/nagios/plugins/check_sip2.pl:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/icinga/plugins/check_sip2.pl
    - mode: 755
    - stateful: True
    - require:
      - pkg: nagiospkgs
