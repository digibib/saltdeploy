saltfiles: salt://koha/files
filerepo: http://datatest.deichman.no/saltfiles/koha/
circulationstart: "2013-10-01"
daysbeforereturn: 14
dummypatrons: 100

include:
  - koha.elasticsearch
  - koha.virtuoso
