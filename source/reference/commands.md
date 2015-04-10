---
title: Commands
section: intro
subsection: commands
sidebar: _toc.html
language_type: ruby
---
# Commands

<p class="lead">Passenger provides a number of commands that you can use. Here you will learn which commands are available and what they are used for.</p>

It's a good idea to know what commands are available, but you can go a long way without knowing them all. Feel free to [skip this section](process_management.html) and use it as a reference later.

**Table of contents**

<ol class="toc-container"><li>Loading...</li></ol>

## passenger

The `passenger` command starts or stops a Passenger server in [Standalone mode](fundamental_concepts.html#multiple-integration-modes). If you have read [the 5 minute quickstart](../../start/ruby.html) then you have already encountered the `passenger` command.

`passenger` is the most basic command, and is often used during development. Throughout this basics walkthrough, we will encounter this command often.

### Starting a server

You can start a Passenger Standalone instance by running `passenger start`. This .

You can have Passenger serve your app by going to your app's directory and running `passenger start`. Here is a short example:

<pre class="highlight"><%= passenger_command_prefix_html(locals) %>passenger start</pre>

For a more complete example, please refer to [the 5 minute quickstart](../../start/ruby.html).

### Stopping a server

If there is a Passenger instance running.

<pre class="highlight"><%= passenger_command_prefix_html(locals) %>passenger stop</pre>

### Checking whether the server is running

## passenger-config

The `passenger-config` command is a tool for managing, controlling and configuring a Phusion Passenger instance or installation. Where the `passenger` command covers functionality that is relevant to the Standalone mode only, the `passenger-config` commands covers functionality all functionality that is not specific to an [integration mode](fundamental_concepts.html#multiple-integration-modes).

`passenger-config` is an advanced command. You don't need to use it for day-to-day operations, but we teach you about it now so that you know it exists.

`passenger-config` accepts a number of subcommands. Here is a small excerpt from its `--help` message:

<pre class="highlight"><%= passenger_command_prefix_html(locals) %>passenger-config --help
<span class="output">Usage: passenger-config <COMMAND> [OPTIONS...]

  Tool for managing, controlling and configuring a Phusion Passenger instance
  or installation.

Management commands:
  detach-process         Detach an application process from the process pool
  restart-app            Restart an application
...</span></pre>

For example, you can use `passenger-config restart-app` to tell a Passenger instance to restart an app, regardless of whether the Passenger instance in question is running in Standalone, Nginx or Apache integration mode.

You can learn more about `passenger-config` in the [guides](../../../guides/) and the [reference](../../../reference/).

## passenger-status, passenger-memory-stats

These commands are tools for displaying the status of Passenger's own processes, as well as the processes managed by Passenger. [Process management](process-management.html) will be covered later in this walkthrough.

`passenger-status` and `passenger-memory-stats` are advanced commands. You don't need to use them for day-to-day operations. Most of the time, you only use them when you want to find out whether there is something wrong. But we teach you about them now so that you know they exist.

## Other commands

The commands `passenger-install-nginx-module` and `passenger-install-apache2-module` are responsible for installing Passenger's Nginx and Apache integration mode, respectively. You won't need to use these commands at all to master the basics. These commands and the integration modes will be covered in the [deployment walkthroughs](../../deploy/ruby/).

## Next step

Now that understand what commands Passenger makes available, it's time to consider process management, a key feature in Passenger. Process management is what allows Passenger to keep your application stable and to maximize performance.

<a href="process_management.html" class="btn btn-primary btn-lg">Continue &raquo;</a>
