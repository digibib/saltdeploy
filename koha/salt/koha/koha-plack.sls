##########
# KOHA PLACK SETUP
##########

##########
# PERL CPAN PACKAGES
##########

plack_pkgs:
  pkg.latest:
  - pkgs:
    - dh-make-perl
    - libmodule-build-perl
    - libmodule-build-tiny-perl
    - libextutils-autoinstall-perl
    - libplack-perl
    - libcgi-emulate-psgi-perl 
    - libfile-pushd-perl 
    - libtext-microtemplate-perl 
    - libclass-method-modifiers-perl
    - libcss-minifier-xs-perl 
    - libjavascript-minifier-xs-perl 
    - libmodule-versions-report-perl
    - libcgi-compile-perl

# cgi_compile:
#   cmd.run:
#     - name: sudo dh-make-perl --install --cpan CGI::Compile

# module_versions:
#   cmd.run:
#     - name: sudo dh-make-perl --install --cpan Module::Versions

plack_debug:
  cmd.run:
    - name: sudo dh-make-perl --install --cpan Plack::Middleware::Debug
    - require:
      - pkg: plack_pkgs

plack_minifier:
  cmd.run:
    - name: sudo dh-make-perl --install --cpan Plack::Middleware::Static::Minifier
    - require:
      - pkg: plack_pkgs

plack_dbiprofile:
  cmd.run:
    - name: sudo dh-make-perl --build --cpan Plack::Middleware::Debug::DBIProfile
    - require:
      - pkg: plack_pkgs

##########
# PLACK .PSGI FILES
##########

/usr/share/koha/opac.psgi:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/koha-tmpl/plack_opac.psgi.tmpl

/usr/share/koha/intranet.psgi:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/koha-tmpl/plack_intranet.psgi.tmpl

# # run opac
# KOHA_CONF=/etc/koha/sites/{{ pillar['kohaname'] }}/koha-conf.xml PERL5LIB=/usr/share/koha/lib plackup --reload opac.psgi

# # run intranet
# KOHA_CONF=/etc/koha/sites/{{ pillar['kohaname'] }}/koha-conf.xml PERL5LIB=/usr/share/koha/lib plackup --reload --port 5001 intranet.psgi



