# SauceLabs SauceConnect Cookbook

Installs SauceConnect 4.4.x on systemd systems

You must provide a value for the following two attributes:
```
default['sc']['server']['api_user'] = nil
default['sc']['server']['api_key'] = nil
```
You can install multiple instances of the SauceConnect agent by overriding:
```
default['sc']['server']['ports'] = ['4445']
```
