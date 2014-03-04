########
# KOHA USE DEICHMANREPO
########

# deichman repo
deichmanrepo:
  pkgrepo.managed:
    - humanname: Deichman APT Repo
    - name: deb http://datatest.deichman.no/repositories/koha squeeze main
    - file: /etc/apt/sources.list.d/deichmanrepo.list
    - key_url: http://datatest.deichman.no/repositories/public.gpg
    - require_in:
      - pkg: update_koha

update_koha:
  pkg.latest:
    - pkgs:
      - koha-kommon