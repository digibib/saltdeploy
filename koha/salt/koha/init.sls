##########
# KOHA Development server
# BASED ON UBUNTU RARING SERVER 64bit
# PACKAGES
##########

koharepo:
  pkgrepo.managed:
    - name: deb http://debian.koha-community.org/koha squeeze main
    - key_url: http://debian.koha-community.org/koha/gpg.asc

installdeps:
  pkg.installed:
    - pkgs:
      - language-pack-nb
      - openssh-server
      - python-software-properties
      - software-properties-common
      - libnet-ssleay-perl 
      - libcrypt-ssleay-perl
      - apache2
      - mysql-client
      - mysql-server
    - skip_verify: True

########
# APACHE
########

/etc/apache2/ports.conf:
  file.append:
    - text:
      - Listen 8080
      - Listen 8081
    - stateful: True

apacheconfig:
  file.managed:
    - name: /etc/apache2/sites-available/{{ pillar['koha']['instance'] }}.conf
    - source: {{ pillar['saltfiles'] }}/apache.tmpl
    - template: jinja
    - context:
      OpacPort: 8080
      IntraPort: 8081
      ServerName: {{ pillar['koha']['instance'] }}

sudo a2enmod rewrite:
  cmd.run:
    - require:
      - pkg: installdeps

sudo a2dismod mpm_event:
  cmd.run:
    - require:
      - pkg: installdeps

sudo a2dismod mpm_itk:
  cmd.run:
    - require:
      - pkg: installdeps

sudo a2dismod mpm_prefork:
  cmd.run:
    - require:
      - pkg: installdeps

sudo a2enmod mpm_itk:
  cmd.run:
    - require:
      - pkg: installdeps

sudo a2enmod cgi:
  cmd.run:
    - require:
      - pkg: installdeps

sudo a2dissite 000-default:
  cmd.run:      
    - require:
      - pkg: installdeps

apache2:
  service:
    - running
    - require:
      - pkg: installdeps
      - cmd: sudo a2enmod rewrite
      - cmd: sudo a2enmod cgi
      - cmd: sudo a2dissite 000-default
      - file: /etc/apache2/ports.conf

##########
# KOHA-COMMON
##########

kohacommon:
  pkg.installed:
    - name: koha-common
    - skip_verify: True
    - require:
      - pkgrepo: koharepo
      - pkg: installdeps

##########
# MYSQL
##########

mysqlrepl1:
  file.replace:
    - name: /etc/mysql/my.cnf
    - pattern: max_allowed_packet.+$
    - repl: max_allowed_packet = 64M

mysqlrepl2:
  file.replace:
    - name: /etc/mysql/my.cnf
    - pattern: wait_timeout.+$
    - repl: wait_timeout = 6000

mysql:
  service:
    - running
    - require:
      - pkg: installdeps
    - watch:
      - file: /etc/mysql/my.cnf

