# sseapi-plugin-formula
Salt State to Install and Configure SaltStack Enterprise Master Plugin

## Available states

- [`sseapi`](#sseapi)

### sseapi

- Manage sseapi config

```yaml
sseapi:
  sseapi_username: root
  sseapi_password: salt
  sseapi_endpoint: sseapi.example.com
  sseapi_ssl_enabled: True
  sseapi_ssl_validation: True
  sseapi_poll_interval: 10
  sseapi_request_timeout: 60
  sseapi_update_interval: 60
  eapi_egg: SSEAPE-6.0.0-py2.7.egg
  eapi_egg_path: /usr/local/lib/python2.7/dist-packages/
  eapi_egg_download_url: https://localhost
```
