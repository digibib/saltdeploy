##########
# KOHA PURGE STATE
##########

# purge koha instance
purgekohainstance:
  cmd.run:
    - name: sudo koha-remove {{ opts['kohaname'] }}

# purge stale mysql admin user
dropmysqlusers:
  cmd.run:
    - name: 'echo "drop user flesk,flesk@localhost; flush privileges;" | mysql -u root > /dev/null 2>&1'
    - require: 
      - cmd: purgekohainstance