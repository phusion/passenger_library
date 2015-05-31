---
title: Working with the Apache configuration file
section: indepth
---
# Working with the Apache configuration file

If you want to [install Passenger in its Apache integration mode](<%= url_for '/guides/install/passenger_apache/index.html' %>) then you will reach a point where you have to edit Apache the configuration file. This page provides information for those who are not familiar with how the Apache configuration file and its related directories are organized.

## The location of the Apache configuration file

On most systems the Apache configuration file is located in one of these locations:

 * `/etc/apache2/httpd.conf`
 * `/etc/apache2/apache2.conf`
 * `/etc/httpd/httpd.conf`

Furthermore On OS X Server >= 10.8 Mountain Lion the location of the Apache configuration file depends on whether you use Web Services or not. If you do, then the configuration file is in `/Library/Server/Web/Config/apache2/httpd_server_app.conf`. If you do not, then the configuration file is in `/etc/apache2/httpd.conf`.

## mods-enabled and sites-enabled

To allow better organization, many operating systems and Apache distributions also read configuration files in the `conf.d`, `mods-enabled` and `sites-enabled` subdirectories.

`mods-enabled` contains symlinks to files in `mods-available`. This latter subdirectory contains config files for all available modules, while `mods-enabled` contains only a subset, namely the modules that should actually be enabled. The symlinks are created using the `a2enmod` tool. `*.load` files contain `LoadModule` directives, while `*.conf` files contain all other configuration directives.

## Storing Passenger configuration snippets

If you can, you should use `mods-enabled`/`mods-available` to store Passenger configuration. Assuming that your Apache configuration directory is `/etc/apache2`:

 * Create `/etc/apache2/mods-available/passenger.load` and paste the `LoadModule ...` directive that `passenger-install-apache2-module` outputs.
 * Create `/etc/apache2/mods-available/passenger.conf` and paste the `PassengerRoot` and other Phusion Passenger options.
 * Enable by running `sudo a2enmod passenger`.

If the `mods-enabled` mechanism is not available then you can paste configuration snippets into `httpd.conf` or `apache2.conf` directly.

## See also

 * [Installing Passenger (open source edition) in production with Apache](<%= url_for '/guides/install/passenger_apache/index.html' %>)
 * [Installing Passenger Enterprise in production with Apache](<%= url_for '/guides/install/passenger_enterprise_apache/index.html' %>)
 * [Unixmen.com: How to enable and disable Apache modules](http://www.unixmen.com/how-to-enable-and-disable-apache-modules/)
 * [Ubuntu manual page for 'a2enmod'](http://manpages.ubuntu.com/manpages/trusty/man8/a2enmod.8.html)
