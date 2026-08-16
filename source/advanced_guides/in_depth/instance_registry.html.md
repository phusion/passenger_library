---
title: Instance registry
advanced_guides: true
breadcrumb: true
disabled_langs:
- :python
- :node
- :meteor
---

# Instance registry

The instance registry is a directory that keeps track of running Passenger instances, allowing them to be discovered by Passenger tools and processes. Within the registry, each Passenger instance has a unique temporary subdirectory for that instance, called the [Instance directory](instance_directory.html), with the name `passenger.<UNIQUE ID>`.

An instance directory contains temporary runtime state, such as Unix domain sockets (for communicating with Passenger background processes and application processes) and instance-specific credential files. To learn more about the contents of instance directories, see [Instance directory](instance_directory.html).

When you run tools such as `passenger-status`, they consult the registry to discover running instances. If only a single instance is running, then they operate on that instance only. If there are more, they ask you to specify the instance on which to operate.

## Location

Default:

- When installed via APT/YUM packages: `/var/run/passenger-instreg`
- Otherwise: `/tmp`. Warning: this is actually a bad location, and we advise you to change this! See [Conflicts with tmp cleaners](#conflicts-with-tmp-cleaners) and [Security considerations](#security-considerations).

Configurable via:

<table class="table table-bordered table-striped">
  <tr>
    <td>Apache</td>
    <td><pre class="highlight">PassengerInstanceRegistryDir</pre></td>
  </tr>
  <tr>
    <td>Nginx, Standalone with Nginx config template</td>
    <td><pre class="highlight">passenger_instance_registry_dir</pre></td>
  </tr>
  <tr>
    <td>Standalone (CLI)</td>
    <td><pre class="highlight">passenger start --instance-registry-dir</pre></td>
  </tr>
  <tr>
    <td>Standalone (config file)</td>
    <td><pre class="highlight">instance_registry_dir</pre></td>
  </tr>
</table>

## Conflicts with tmp cleaners

Using `/tmp` as the instance registry directory is discouraged. On many systems, `/tmp` is periodically cleaned by a temporary-file cleaner. If it removes an instance directory belonging to a running Passenger instance, that instance becomes partially unusable until Passenger is restarted. For example, Passenger may no longer be able to communicate with application processes.

Passenger mitigates this risk by periodically updating timestamps within its instance directories. However, this does not reliably prevent temporary-file cleaners from removing them.

Therefore, you should configure the instance registry to a location other than `/tmp`.

## Security considerations

The instance registry directory should only be writable by the user under which the Passenger Watchdog runs.

In the common multitenant configuration, where the web server runs as root and user switching is enabled, the Passenger Watchdog also runs as root. In this configuration, the instance registry directory should be owned by root, writable only by root, and readable and executable by other users.

Read and executable access to the instance registry directory allows a user to discover running Passenger instances. It does not, by itself, allow that user to query those instances or perform administrative operations on them. Access to those operations is controlled separately by the files inside each instance directory.

When Passenger is installed through APT or YUM packages, the instance registry directory is created with multitenancy-appropriate ownership and permissions automatically.

## Interaction with web server reloads

Reloading the web server replaces the current Passenger instance with a new one. The new instance receives a new instance directory, so the instance directory path changes after a reload.

## Stale instance directories and cleanup

Passenger normally removes its instance directory when the instance shuts down. This cleanup may not occur after an abnormal termination, such as a system crash or power failure, leaving a stale instance directory behind.

When `passenger-status` runs, it attempts to detect stale instance directories and remove them if it has sufficient permissions.
