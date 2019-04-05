# sseapi-plugin-formula
Salt State to Install and Configure SaltStack Enterprise Master Plugin

## Available states

- [`sseapi`](#sseapi)

### sseapi

- Manage sseapi config

```yaml
sseapi:
  sse_eapi_username: root
  sse_eapi_password: salt
  sse_eapi_endpoint: sseapi.example.com
  sse_eapi_ssl_enabled: True
  sse_eapi_ssl_validation: True
  eapi_egg: SSEAPE-6.0.0-py2.7.egg
  eapi_egg_path: /usr/local/lib/python2.7/dist-packages/
  eapi_egg_download_url: https://localhost
```
