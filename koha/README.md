Koha Vagrant and Salt Config
==========

Prerequisites:

1. Files not included in the repo that must be created

    ./salt/koha/files/passwd:
    {{ pillar['kohaname'] }}:username:password

    ./salt/koha/files/marc2rdf/marc2rdf_settings.json
    marc2rdf settings file. (see example on github.com/digibib/marc2rdf)

2. Pillar variables (local settings):

edit:

    ./koha/pillar/koha/init.sls


Run
===

To initiate, simply run 

    vagrant up

And the image will download, boot and provision automagically!

Ports forwarded:

* 8080: OPAC
* 8081: INTRANET
* 3000: marc2rdf
* 8890: virtuoso

    vagrant ssh

to get into the box.


States that can be run after provisioning:

* koha-create.sls        create empty instance
* koha-defaults.sls      load defaults
* koha-dummycirc.sls     dummy circulation
* koha-dummypatrons.sls  dummy patrons
* koha-import-15000.sls  import 15000 biblio items
* koha-import-all.sls    import all biblio items (takes a LONG time) 
* koha-import.sls        import 500 biblio items
* koha-locales.sls       install nb locales
* koha-marc2rdf.sls      install and setup marc2rdf and virtuoso
* koha-oai.sls           force rebuild oai sets
* koha-purge.sls         purge instance
* koha-restore-all.sls   restore full instance from backup
* koha-restore.sls       restore 500 biblio backup
* koha-virtuoso.sls      setup virtuoso 7 (Not used)

To run individual states, run e.g.: (without .sls)

    echo "sudo salt-call state.sls examplestate" | vagrant ssh

Or do it from within the Virtualbox