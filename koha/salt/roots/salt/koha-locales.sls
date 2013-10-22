########
# KOHA LOCALES STATE
########

/usr/share/koha/misc/translator/po/nb-NO-i-staff-t-prog-v-3006000.po:
  file.managed:
    - source: http://171.23.133.203/saltfiles/koha/nb-NO-i-staff-t-prog-v-3006000.po
    - source_hash: md5=ac6e45a7bd114914dadb112b77a46f84
    - stateful: True

/usr/share/koha/misc/translator/po/nb-NO-i-opac-t-prog-v-3006000.po:
  file.managed:
    - source: http://171.23.133.203/saltfiles/koha/nb-NO-i-opac-t-prog-v-3006000.po
    - source_hash: md5=de0285fbd4bbc9979d58f203b9f8a287
    - stateful: True

sudo koha-translate --install nb-NO:
  cmd.run:
    - require:
      - file: /usr/share/koha/misc/translator/po/nb-NO-i-staff-t-prog-v-3006000.po
      - file: /usr/share/koha/misc/translator/po/nb-NO-i-opac-t-prog-v-3006000.po    
    - watch: 
      - file: /usr/share/koha/misc/translator/po/nb-NO-i-staff-t-prog-v-3006000.po
      - file: /usr/share/koha/misc/translator/po/nb-NO-i-opac-t-prog-v-3006000.po