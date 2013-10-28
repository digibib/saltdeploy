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

# /usr/local/src/virtuoso7.zip:
#   file.managed:
#   - source: {{ opts['filerepo'] }}/virtuoso7.zip
#   - source_hash: md5=4d288bb90f6e3b72c6b349df411d0f11

# unpack_virtuoso:
#   cmd.run:
#     - name: unzip virtuoso7.zip
#     - cwd: /usr/local/src/
#     - require:
#       - file: /usr/local/src/virtuoso7.zip

generate_virtuoso:
  cmd.run:
    - cwd: /usr/local/src/virtuoso-opensource-stable-7
    - name: CFLAGS="-O2 -m64" ./autogen.sh
    # - require:
    #   - cmd: unpack_virtuoso

build_virtuoso:
  cmd.run:
    - cwd: /usr/local/src/virtuoso-opensource-stable-7
    - name: CFLAGS="-O2 -m64" ./configure --prefix=/data/virtuoso-opensource-7 --disable-dbpedia-vad --disable-demo-vad --disable-fct-vad --disable-isparql-vad --disable-ods-vad --disable-rdfmappers-vad --disable-rdb2rdf-vad --disable-sparqldemo-vad --disable-syncml-vad --disable-tutorial-vad --disable-bpel-vad --with-port=1111
    - require:
      - cmd: generate_virtuoso

install_virtuoso:
  cmd.run:
    - cwd: /usr/local/src/virtuoso-opensource-stable-7
    - name: make install
    - require:
      - cmd: build_virtuoso

/data/virtuoso-opensource-7/database/virtuoso.ini:
  file.managed:
    - source: salt://files/virtuoso/virtuoso.ini.production
    - template: jinja
    - context:
      User: {{ opts['kohaname'] }}-koha

virtuoso:
  service.running:
    - enable: True
    - require:
      - file: /data/virtuoso-opensource-7/database/virtuoso.ini
      - file: /etc/init/virtuoso.conf