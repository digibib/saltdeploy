########
# KOHA nb-NO LOCALES STATE
########

/usr/share/koha/misc/translator/po/nb-NO-i-staff-t-prog-v-3006000.po:
  file.managed:
    - source: {{ pillar['filerepo'] }}/nb-NO-i-staff-t-prog-v-3006000.po
    - source_hash: md5=ac6e45a7bd114914dadb112b77a46f84
    - stateful: True

/usr/share/koha/misc/translator/po/nb-NO-i-opac-t-prog-v-3006000.po:
  file.managed:
    - source: {{ pillar['filerepo'] }}/nb-NO-i-opac-t-prog-v-3006000.po
    - source_hash: md5=de0285fbd4bbc9979d58f203b9f8a287
    - stateful: True

/usr/share/koha/misc/translator/po/nb-NO-pref.po:
  file.managed:
    - source: {{ pillar['filerepo'] }}/nb-NO-pref.po
    - source_hash: md5=abcdfe8b54a5230356831150f1932cf3
    - stateful: True

/usr/share/koha/misc/translator/po/nb-NO-opac-bootstrap.po:
  file.managed:
    - source: {{ pillar['filerepo'] }}/nb-NO-opac-bootstrap.po
    - source_hash: md5=8b8c72bcd8016b90fa6c54b3e8196845
    - stateful: True

translate:
  cmd.run:
    - name: koha-translate --install nb-NO
    - require:
      - file: /usr/share/koha/misc/translator/po/nb-NO-i-staff-t-prog-v-3006000.po
      - file: /usr/share/koha/misc/translator/po/nb-NO-i-opac-t-prog-v-3006000.po
      - file: /usr/share/koha/misc/translator/po/nb-NO-pref.po
      - file: /usr/share/koha/misc/translator/po/nb-NO-opac-bootstrap.po
    - watch: 
      - file: /usr/share/koha/misc/translator/po/nb-NO-i-staff-t-prog-v-3006000.po
      - file: /usr/share/koha/misc/translator/po/nb-NO-i-opac-t-prog-v-3006000.po
      - file: /usr/share/koha/misc/translator/po/nb-NO-opac-bootstrap.po
      - file: /usr/share/koha/misc/translator/po/nb-NO-pref.po

########
# LOCAL MODS - ENCODING ISSUES
########

/usr/share/koha/intranet/htdocs/intranet-tmpl/prog/nb-NO/modules/admin/preferences/circulation.pref:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/koha-tmpl/circulation.pref
    - watch:
      - cmd: translate

/usr/share/koha/intranet/htdocs/intranet-tmpl/prog/nb-NO/modules/admin/preferences/opac.pref:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/koha-tmpl/opac.pref
    - watch:
      - cmd: translate

/usr/share/koha/intranet/htdocs/intranet-tmpl/prog/nb-NO/modules/admin/preferences/patrons.pref:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/koha-tmpl/patrons.pref
    - watch:
      - cmd: translate