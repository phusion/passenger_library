---
title: Getting started with Ruby + Phusion Passenger
section: start
---
# Getting started with Ruby + Phusion Passenger

<p class="lead">This 5 minute tutorial teaches you to start your application in a Phusion Passenger server. Feel what Passenger is and how it works.</p>

## Updating your gem bundle

Open your Gemfile and add "passenger":

~~~ruby
gem "passenger"
~~~

Now open a terminal, go to your application's directory and run bundle install to install your gem bundle:

~~~bash
cd /path-to-your-app
bundle install
# => ...
# => Installing passenger x.x.x
# => ...
# => Your bundle is complete!
~~~

## Running the server

You are now you are ready to run the Passenger server. Run:

~~~bash
bundle exec passenger start
# => ======= Phusion Passenger Standalone web server started =======
# => PID file: /Users/phusion/myapp/tmp/pids/passenger.3000.pid
# => Log file: /Users/phusion/myapp/log/passenger.3000.log
# => Environment: development
# => Accessible via: http://0.0.0.0:3000/
# => 
# => You can stop Phusion Passenger Standalone by pressing Ctrl-C.
# => ===============================================================
~~~

As you can see in the output, Passenger is now serving your app on [http://0.0.0.0:3000/](http://0.0.0.0:3000/). So if you go to that URL, you will should see your application:

~~~bash
curl http://0.0.0.0:3000/
# => your app's front page HTML
~~~

<div class="note">
  <h3 id="no-bundle-exec-rails-server-yet">No "bundle exec rails server" yet</h3>
  <p>If you use Rails, then you may be used to using <code>bundle exec rails server</code> to start a server. Passenger currently does not integrate into the <code>rails server</code> mechanism, so instead of <code>bundle exec rails server</code>, run <code>bundle exec passenger start</code> instead.</p>
</div>

## Logs

Passenger prints its own logs not only to the terminal, but also to a log file. During startup, Passenger tells you what log file it used. This is typically `log/passenger.XXXX.log`.

There are also the *application* logs, such as `log/development.log` and `log/production.log`. These logs are completely separate from Passenger's own logs. If you use Rails, then Passenger will also print your application logs to the terminal, but it will not print them into Passenger's log file.

If you do not use Rails then Passenger may not print your logs to the terminal at all. In that case it is up to you to manually view those log files, e.g. with the Unix `tail` tool.

## Stopping the server

There are two ways to stop the server. The first is by pressing Ctrl-C in the terminal.

~~~bash
bundle exec passenger start
# => ...
# => (press Ctrl-C here)
# => Stopping web server... done!
~~~

The second way is by starting a seperate terminal, changing the working directory to your application, and running `bundle exec passenger stop`:

~~~bash
cd /path-to-your-app
bundle exec passenger stop
~~~

## Conclusion

<p class="hidden-xs"><img src="../../images/award.png" alt="Achievement unlocked. Image taken from https://openclipart.org/detail/60109/award-symbol-by-sheikh_tuhin" class="pull-right"></p>
<p class="visible-xs text-center"><img src="../../images/award.png" alt="Achievement unlocked. Image taken from https://openclipart.org/detail/60109/award-symbol-by-sheikh_tuhin" width="128"></p>

Congratulations! Now that you've passed this tutorial and seen Passenger in action, you may be interested in intermediate-level walkthroughs.

Learn more about Passenger and its features:

<a href="../intro/ruby/" class="btn btn-primary">Read introduction walkthrough &raquo;</a>

Deploy your app to production:

<a href="../deploy/ruby/" class="btn btn-primary">Read deployment walkthrough &raquo;</a>

...or <a href="../..">go back to the front page</a>.
