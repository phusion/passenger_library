---
title: Preparing a sample application
section: basics
subsection: preparing_sample_app
sidebar: toc.html
---
# Preparing a sample application

<p class="lead">Throughout the rest of this basics walkthrough, we will demonstrate Passenger's basic features through a sample Meteor application. In this step we will show you how to create this sample application.</p>

## Create the app

Let us create an example Meteor app directory structure in your home directory. We use the builtin Meteor leaderboard example app. If you have already done this as part of the [quickstart](../../start/meteor.html), feel free to skip to ["Create an app package"](#create-an-app-package).

<pre class="highlight"><span class="prompt">$ </span>cd ~
<span class="prompt">$ </span>meteor create --example leaderboard
<span class="prompt">$ </span>cd leaderboard</pre>

## Create an app package

In the previous step, you only created a Meteor app in development mode. In this walkthrough, we also need a *packaged* version of your Meteor sample app. A packaged Meteor app contains the Meteor runtime and various other necessary things for running a Meteor app in production. Some Passenger features are only compatible with packaged Meteor apps.

Inside the `leaderboard` directory, use the `meteor build` command to create a package directory.

<pre class="highlight"><span class="prompt">$ </span>meteor build ../leaderboard-package --directory</pre>

The packaged app has now been placed in `~/leaderboard-package/bundle`. This packaged app directory doesn't contain any dependencies, so we need to install them. Run:

<pre class="highlight"><span class="prompt">$ </span>cd ../leaderboard-package/bundle/programs/server
<span class="prompt">$ </span>npm install</pre>

Finally, return to the original `leaderboard` app directory:

<pre class="highlight"><span class="prompt">$ </span>cd ../../../../leaderboard</pre>

## Next step

Next, we will introduce you to the `passenger` command, which starts your app in Passenger.

<a href="passenger_command.html" class="btn btn-primary btn-lg">Continue &raquo;</a>
