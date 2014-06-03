########
# VIRTUOSO 
# NOT USED P.T. !!
########

virtuosopkgs:
  pkg.latest:
    - pkgs:
      - libssl-dev
      - gawk
      - gperf 
      - flex 
      - build-essential
      - automake
      - autoconf
      - bison
      - libtool

/usr/local/src/virtuoso7.tar.gz:
  file.managed:
  - source: {{ pillar['filerepo'] }}/virtuoso7.tar.gz
  - source_hash: md5=fec308b5583ab956e5b96fe7e5a0e017

unpack_virtuoso:
  cmd.run:
    - name: tar zxvf virtuoso7.tar.gz -C /usr/local/src/virtuoso7
    - cwd: /usr/local/src/
    - require:
      - file: /usr/local/src/virtuoso7.tar.gz

autogen_virtuoso:
  cmd.run:
    - cwd: /usr/local/src/virtuoso7
    - name: CFLAGS="-O2 -m64" ./autogen.sh
    - require:
      - cmd: unpack_virtuoso

build_virtuoso:
  cmd.run:
    - cwd: /usr/local/src/virtuoso7
    - name: CFLAGS="-O2 -m64" ./configure --prefix={{ pillar['virtuoso']['installdir'] }} --disable-dbpedia-vad --disable-demo-vad --disable-fct-vad --disable-isparql-vad --disable-ods-vad --disable-rdfmappers-vad --disable-rdb2rdf-vad --disable-sparqldemo-vad --disable-syncml-vad --disable-tutorial-vad --disable-bpel-vad --with-port=1111
    - require:
      - cmd: autogen_virtuoso

install_virtuoso:
  cmd.run:
    - cwd: /usr/local/src/virtuoso7
    - name: make install
    - require:
      - cmd: build_virtuoso

/data/virtuoso7/database/virtuoso.ini:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/virtuoso/virtuoso.ini.production
    - template: jinja

/etc/init/virtuoso7.conf:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/virtuoso/virtuoso.conf
    - template: jinja

virtuoso:
  service.running:
    - enable: True
    - require:
      - file: /data/virtuoso7/database/virtuoso.ini
      - file: /etc/init/virtuoso7.conf