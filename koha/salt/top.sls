base:
  '*':
    - koha.devtools
    # States to create a vanilla Koha install 
    - koha
    - koha.koha-install
    - koha.koha-adminuser

    # - koha.koha-deichman
    # - koha.koha-restore
    # - koha.koha-import
    # - koha.koha-import-15000
    # - koha.koha-import-all
    # - koha.koha-dummypatrons
    # - koha.koha-dummycirc
    # - koha.koha-oai
    # - koha.koha-marc2rdf