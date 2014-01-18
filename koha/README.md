Koha Vagrant and Salt Config
==========

Prerequisites:

1. Sensitive are sent via pillar: file admin.sls 

    cp ./pillar/koha/admin.sls.example ./pillar/koha/admin.sls

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

* koha.koha-create.sls        create empty instance
* koha.koha-defaults.sls      load defaults
* koha.koha-dummycirc.sls     dummy circulation
* koha.koha-dummypatrons.sls  dummy patrons
* koha.koha-import-15000.sls  import 15000 biblio items
* koha.koha-import-all.sls    import all biblio items (takes a LONG time) 
* koha.koha-import.sls        import 500 biblio items
* koha.koha-locales.sls       install nb locales
* koha.koha-marc2rdf.sls      install and setup marc2rdf and virtuoso
* koha.koha-oai.sls           force rebuild oai sets
* koha.koha-purge.sls         purge instance
* koha.koha-restore-all.sls   restore full instance from backup
* koha.koha-restore.sls       restore 500 biblio backup
* koha.koha-virtuoso.sls      setup virtuoso 7 (Not used)

To run individual states, run e.g.: (without .sls)

    echo "sudo salt-call state.sls examplestate" | vagrant ssh

Or do it from within the Virtualbox