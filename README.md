# SauceLabs SauceConnect Cookbook

Installs SauceConnect 4.4.x on systemd systems

You must provide a value for the following two attributes:
```
# Typically overridden in the policy file
default['sc']['server']['api_user'] = nil
default['sc']['server']['api_key'] = nil
```
You can install multiple instances by enumerating ports:
```
default['sc']['server']['ports'] = ['4445']
```
You can override the command line parameters passed to Sauce Connect through:
```
# NOTE: We do not deep merge these in the recipe eg. you must include these in your override if you need these.
default['sc']['server']['cmd_options'] =
  ['--se-port "%i"',
   '--logfile -'
  ]
```
