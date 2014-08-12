########
# KOHA VERSION
# This state updates koha syspref 'Version' manually to bypass webinstaller
# alternatively updates koha debian package koha-common if neccessary
########

{% set kohaversion = salt['cmd.run']("perl -e 'require \"/usr/share/koha/intranet/cgi-bin/kohaversion.pl\" ; print kohaversion();'") %}
{% set kohaversionnum = kohaversion.replace('.','')[:-3] %}

{% set debianversion = salt['cmd.run']("dpkg -l | awk '$2==\"koha-common\" { print $3 }'") %}
{% set debianversionnum = debianversion.replace('.','') %}

{% set kohadbversion = ''.join(kohaversion.rsplit('.', 2)) %}

# upgrade koha-common to latest if ...?
# {% if debianversionnum < kohaversionnum %}
# update-koha-common:
#   pkg.latest:
#     - name: koha-common
# {% endif %}

update-koha-dbversion:
  cmd.run:
    - name: >
        echo "INSERT INTO systempreferences (variable,value,options,explanation,type)
        VALUES ('Version','{{ kohadbversion }}',NULL,'The Koha database version. WARNING: Do not change 
        this value manually, it is maintained by the webinstaller',NULL)
        ON DUPLICATE KEY UPDATE value = '{{ kohadbversion }}' ;" | koha-mysql {{ pillar['koha']['instance'] }} 

update_database:
  cmd.run:
    - name: koha-upgrade-schema {{ pillar['koha']['instance'] }}
