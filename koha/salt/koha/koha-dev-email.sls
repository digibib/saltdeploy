########
# KOHA DEV EMAIL STATE
########

nullmailerpkg:
  pkg.latest:
    - pkgs:
      - nullmailer

/etc/nullmailer/remotes:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/smtp-real.conf
    - template: jinja
    - require:
      - pkg: nullmailerpkg

# ugly hack to allow Mail::Sendmail to access smtp
/usr/share/perl5/Mail/Sendmail.pm:
  file.blockreplace:
    - marker_start: "# *************** Configuration you may want to change *******************"
    - marker_end:   "# *******************************************************************"
    - content: |
        # You probably want to set your SMTP server here (unless you specify it in
        # every script), and leave the rest as is. See pod documentation for details
        %mailcfg = (
        # List of SMTP servers:
        'smtp'    => [ qw( {{ pillar['maildomain'] }} ) ],
        'from'    => '{{ pillar['mailfrom'] }}', # default sender e-mail, used when no From header in mail
        'mime'    => 1, # use MIME encoding by default
        'retries' => 1, # number of retries on smtp connect failure
        'delay'   => 3, # delay in seconds between retries
        'tz'      => '', # only to override automatic detection
        'port'    => 25, # change it if you always use a non-standard port
        'debug'   => 0 # prints stuff to STDERR
        );
    - require:
      - file: /etc/nullmailer/remotes

nullmailer:
  service:
    - running
    - require:
      - pkg: nullmailerpkg
    - watch:
      - file: /etc/nullmailer/remotes
      - file: /usr/share/perl5/Mail/Sendmail.pm
