---
title: 'Installation - Passenger + Ruby basics'
section: basics
subsection: installation
sidebar: _toc.html
---
# Installation

Installing Passenger is easy. During development, you use Bundler to install Passenger.

Open your application's Gemfile and add "passenger":

~~~ruby
gem "passenger", ">= <%= MIN_RECOMMENDED_PASSENGER_VERSION %>", require: "phusion_passenger/rack_handler"
~~~

Now open a terminal, go to your application's directory and run bundle install to install your gem bundle:

<pre class="highlight"><span class="prompt">$ </span>cd /path-to-your-app
<span class="prompt">$ </span>bundle install
<span class="output">...
Installing passenger x.x.x
...
Your bundle is complete!</span></pre>

You can verify that it works by querying Passenger's version number:

<pre class="highlight"><span class="prompt">$ </span>bundle exec passenger --version
<span class="output">Phusion Passenger version X.X.X

"Phusion Passenger" is a trademark of Hongli Lai &amp; Ninh Bui.</span></pre>

<div class="note">Installation in production is different, but we'll cover that later in the <a href="../../deploy/ruby/">deployment walkthrough</a>.</div>

## Next step

Installing Passenger in development is as easy as adding it to your Gemfile.

Next, we will consider the `passenger` command, which is responsible for starting and stopping Passenger in its Standalone mode.

<a href="passenger_command.html" class="btn btn-primary btn-lg">Continue &raquo;</a>
