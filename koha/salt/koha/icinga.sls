########
# ICINGA2 SETUP
########

icingapkgs:
  pkg.latest:
    - pkgs:
      - icinga2
      - icinga2-ido-mysql
      - graphite-carbon

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

icinga2:
  service:
    - running
    - watch:
      - cmd: icingaplugins

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
