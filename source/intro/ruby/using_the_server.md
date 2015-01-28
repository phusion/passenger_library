---
title: Using the server
section: intro
---
# Using the server

<p class="lead">This tutorial teaches you to start your application in a Phusion Passenger server.</p>

## Updating your gem bundle

Open your Gemfile and add "passenger":

~~~ruby
gem "passenger"
~~~

Now open a terminal, go to your application's directory and run bundle install to install your gem bundle:

    $ cd /path-to-your-app
    $ bundle install
    ...
    Installing passenger x.x.x
    ...
    Your bundle is complete!

## Running the server

You are now you are ready to run the Phusion Passenger server. Run:

    $ bundle exec passenger start
    ======= Phusion Passenger Standalone web server started =======
    PID file: /Users/phusion/myapp/tmp/pids/passenger.3000.pid
    Log file: /Users/phusion/myapp/log/passenger.3000.log
    Environment: development
    Accessible via: http://0.0.0.0:3000/

    You can stop Phusion Passenger Standalone by pressing Ctrl-C.
    ===============================================================

As you can see in the output, Phusion Passenger is now serving your app on [http://0.0.0.0:3000/](http://0.0.0.0:3000/). So if you go to that URL, you will should see your application.

### No "bundle exec rails server" yet

If you use Rails, then you may be used to using `bundle exec rails server` to start a server. Phusion Passenger currently does not integrate into the `rails server` mechanism, so instead of `bundle exec rails server`, run `bundle exec passenger start` instead.

## Logs

Phusion Passenger prints its own logs not only to the terminal, but also to a log file. During startup, Phusion Passenger tells you what log file it used. This is typically `log/passenger.XXXX.log`.

There are also the *application* logs, such as `log/development.log` and `log/production.log`. These logs are completely separate from Phusion Passenger's own logs. If you use Rails, then Phusion Passenger will also print your application logs to the terminal, but it will not print them into Phusion Passenger's log file.

If you do not use Rails then Phusion Passenger may not print your logs to the terminal at all. In that case it is up to you to manually view those log files, e.g. with the Unix `tail` tool.

## Stopping the server

There are two ways to stop the server. The first is by pressing Ctrl-C in the terminal.

    $ bundle exec passenger start
    ...
    (press Ctrl-C here)
    Stopping web server... done!
    $

The second way is by starting a seperate terminal, changing the working directory to your application, and running `passenger stop`:

    $ cd /path-to-your-app
    $ passenger stop

## Next step

A key feature in Phusion Passenger is [process management](process_management.html). This allows Phusion Passenger to keep your application stable and to maximize performance.

<a href="process_management.html" class="btn btn-primary btn-lg">Continue &raquo;</a>
