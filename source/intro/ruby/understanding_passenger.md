---
title: Understanding Phusion Passenger
section: intro
---

<h1 class="page-header">Understanding Phusion Passenger</h1>

<p class="lead">You've heard that Phusion Passenger is an "application server", but what is that exactly? Why do you need Phusion Passenger to run your Ruby application, and how does it compare to other software? This page explains it all.</p>

## The big picture

Ruby web applications are typically not directly able to listen on the Internet. They need a piece of software that provides Internet HTTP transaction handling. That piece of software is the application server.

The Ruby ecosystem has multiple application servers, all with different features. Phusion Passenger is a popular server, but other popular servers include Unicorn and Puma.

## Versus other software

### Vs Unicorn and Puma

Unicorn and Puma are app servers like Phusion Passenger, but they are quite minimalist in comparison.

Unicorn and Puma provide HTTP transaction handling as well as limited amounts of problem management.

### Vs Apache and Nginx

### Vs Capistrano

## What Passenger doesn't do

## Next step

Now that you have a basic understanding of what Phusion Passenger is, [get it going and see it in action](get_going.html).
