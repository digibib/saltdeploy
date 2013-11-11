##########
# KOHA PURGE STATE
##########

# purge koha instance
purgekohainstance:
  cmd.run:
    - name: koha-remove {{ pillar['kohaname'] }}

# purge stale mysql admin user
dropmysqlusers:
  cmd.run:
    - name: "echo \"drop user {{ pillar['adminuser'] }},{{ pillar['adminuser'] }}@localhost; flush privileges;\" | mysql -u root > /dev/null 2>&1"
    - require: 
      - cmd: purgekohainstance

purgezebra:
  cmd.run:
    - name: rm -rf /var/lib/koha/{{ pillar['kohaname'] }}
    - watch: 
      - cmd: purgekohainstance

purgeconfig:
  cmd.run:
    - name: rm -rf /etc/koha/sites/{{ pillar['kohaname'] }}
    - watch: 
      - cmd: purgekohainstance
