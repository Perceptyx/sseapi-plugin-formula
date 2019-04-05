{#
  Salt State to Install and Configure SaltStack Enterprise Master Plugin 
#}

{% set eapi_endpoint = salt['pillar.get']('sse:sse_eapi_endpoint', 'localhost') %}
{% set eapi_ssl_enabled = salt['pillar.get']('sse:sse_eapi_ssl_enabled', 'True') %}
{% if eapi_ssl_enabled %}
{% set eapi_url = "https://%s"|format(eapi_endpoint) %}
{% else %}
{% set eapi_url = "http://%s"|format(eapi_endpoint) %}
{% endif %}
{% set eapi_ssl_validation = salt['pillar.get']('sse:sse_eapi_ssl_validation', 'False') %}
{% set eapi_username = salt['pillar.get']('sse:sse_eapi_username', 'root') %}
{% set eapi_password = salt['pillar.get']('sse:sse_eapi_password', 'salt') %}

{% set eapi_egg = salt['pillar.get']('sse:eapi_egg') %}
{% set eapi_egg_hash = salt['pillar.get']('sse:eapi_egg_hash') %}
{% set eapi_egg_path = salt['pillar.get']('sse:eapi_egg_path', '/usr/lib/python2.7/site-packages/') %}
{% set eapi_egg_download_url = salt['pillar.get']('sse:eapi_egg_download_url') %}

remove_old_sseapi_modules:
  cmd.run:
    - name: 'ls -d SSEAPE* | grep -v {{ eapi_egg }} | xargs rm -Rf'
    - cwd: {{ eapi_egg_path }}
    - onlyif:
      - ls -d {{ eapi_egg_path }}SSEAPE* | grep -v {{ eapi_egg }}


{% if not salt['file.directory_exists'](eapi_egg_path + eapi_egg) %}

get_eapi_egg:
  file.managed:
    - name: /tmp/{{ eapi_egg }}
    - source: {{ eapi_egg_download_url }}/{{ eapi_egg }}
    - source_hash: {{ eapi_egg_hash }}

install_eapi_egg:
  cmd.run:
    - name: easy_install /tmp/{{ eapi_egg }}

delete_eapi_egg_tmp_file:
  file.absent:
    - name: /tmp/{{ eapi_egg }}

{% endif %} 

sseapi_plugin_conf:
  file.managed:
    - name: /etc/salt/master.d/raas.conf
    - source: salt://{{ slspath }}/files/raas.conf.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
    - context:
        eapi_url: {{ eapi_url }}
        eapi_username: {{ eapi_username }}
        eapi_password: {{ eapi_password }}
        eapi_ssl_enabled: {{ eapi_ssl_enabled }}
        eapi_ssl_validation: {{ eapi_ssl_validation }}

sseapi_master_paths:
  file.managed:
    - name: /etc/salt/master.d/eAPIMasterPaths.conf
    - source: salt://{{ slspath }}/files/eAPIMasterPaths.conf.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        eapi_egg_path: {{ eapi_egg_path }}
        eapi_egg: {{ eapi_egg }}
