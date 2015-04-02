---
title: Understanding Phusion Passenger
section: intro
---
# Understanding Phusion Passenger

Phusion Passenger is an open source, polyglot (multi-language) <strong>application server</strong>. It simplifies Node.js deployment and administration and adds many powerful features that help you monitor your app and diagnose problems.

<p><img src="passenger_node.png" width="500" height="137" class="img-responsive center-block"></p>

### A holistic approach

If you've deployed a Node.js app to production before, then you may know that it involves glueing a bunch of different tools together:

 * Nginx as a reverse proxy.
 * Forever/PM2 to keep your app running and to manage your app's processes.
 * An init script to start your app at boot.
 * The Cluster module for multi-core usage.

We dislike having so many moving parts, so we've created Passenger, which takes more of a holistic approach to the problem. As an application server, Passenger is conceptually like Nginx, Forever/PM2, the init script and the cluster module combined in a single, lightweight, easy-to-use package. Instead needing you to glue different tools together, Passenger takes care of the "gluing together" for you.

The holistic approach saves time and reduces operational complexity.

## Key benefits

### Diagnosis made easy

With the classical many-tools approach, it's hard to find out what the application is doing. For example, the Nginx proxy module doesn't provide a way to inspect active connections. Passenger provides simple and powerful tools that can help you with diagnosing application behavior.

### Multi-core and load balancing improved

The Cluster module requires a lot of boilerplate code and doesn't work well with WebSockets. Passenger can take advantage of multiple cores, just like the Cluster module, but without boilerplate code. Passenger also load balances traffic on the HTTP level instead of TCP level, so that even WebSocket connections can be load balanced well.

### Multitenancy

Run multiple Node.js applications on a single server easily and without hassle.

### Caching and static file acceleration

Static files are directly served by the web server (Nginx/Apache), not by Node.js. This offloads the Node.js application from handling those things.

### Lightweight

Passenger is written in optimized C++, and is designed to be small and fast. Data structures are optimized for CPU cache locality. Dynamic memory allocation is avoided as much as possible. Not a single microsecond is wasted. Weighting only a few megabytes, Passenger is a very lightweight tool that comes packed with useful features.

## What Passenger doesn't do

Passenger follows the Unix philosophy of doing a small number of things, but doing them well. So there are a number of things that are (currently) outside Passenger's scope. Passenger may or may not take care of some of these some time in the future.

 * **Setting up a server with an operating system**<br>
   Passenger assumes that you already have a server with an working operating system on it. Passenger is not a hosting service. It is software that is to be installed on a server.<br>
   However, the Passenger Library contains excellent [documentation on setting up a server](../../deploy/nodejs/).
 * **Installing Node.js**<br>
   To run Node.js apps on Passenger, you must already have Node.js installed. Passenger doesn't do that for you. Passenger doesn't care how you install Node.js though; you sometimes just need to tell Passenger where Node.js is.<br>
   However, the Passenger Library contains excellent [documentation on setting up a server](../../deploy/nodejs/).
 * **Transferring the application code and files to the server**<br>
   Passenger does not transfer the application code and files to the server for you. To do this, you must use tools like Git, scp, FTP, Capistrano, Fabric, etc. Passenger assumes that the application code and files are already on the server, and does not care which tool you use to make that so.
 * **Installing application dependencies**<br>
   Passenger does not install your application's dependencies for you.
 * **Managing the database**<br>
   If your application requires a database, then Passenger does not install that database for you, nor does it sets up database accounts and tables for you. They must already be set up by the time you deploy your application to Passenger.
 * **Managing auxiliary daemons and services**<br>
   If your application requires additional daemons and services, e.g. Memcached or Redis, then Passenger does not manage those. They must already be running.

## Next step

Now that you've seen Passenger in action and understand what it is, it's time to get acquainted with the basic features.

A key feature in Phusion Passenger is [process management](process_management.html). This allows Phusion Passenger to keep your application stable and to maximize performance.

<a href="process_management.html" class="btn btn-primary btn-lg">Continue &raquo;</a>

<a href=".">&laquo; Back to table of contents</a>
