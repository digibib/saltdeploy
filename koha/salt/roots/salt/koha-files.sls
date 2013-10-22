##########
# KOHA FILES STATE
##########

# defaults file with libraries and item types
/home/vagrant/defaults.sql.gz:
  file.managed:
    - source: salt://files/defaults.sql.gz

##########
# IMPORT FILES
##########


