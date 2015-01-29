---
title: Process management
section: intro
---
# Process management

<p class="lead">Phusion Passenger manages multiple processes in order to maximize stability and performance. Learn what processes are, how Passenger manages them and how to use Passenger's command line tools to work with them.</p>

<small>If you already know this, <a href="conclusion.html">skip ahead to Conclusion</a> or <a href="..">go back to the table of contents</a>.</small>

### What are processes?

An instance of an application is called a **process**. Passenger takes care of starting and stopping your application for you. Every time Passenger starts an instance of your application, it is said that an application process is spawned. Every time Passenger stops an instance of your application, it is said that an application process is shut down.

You may also have heard of the term **"thread"**, but threads should not be confused with processes. Threads run *inside* a process, so a process always contains one or more threads. Threads and processes have distinct characteristics.

Initially, Passenger only spawns one application process. But sometimes it may decide to spawn multiple processes. Here are the reasons why this is sometimes beneficial:

 * **Performance**<br>
   The more processes you run, the better the CPU core utilization, up until the hardware limit.
 * **I/O concurrency**<br>
   The more processes you run, the greater the amount of available I/O concurrency.
 * **Stability**<br>
   If an application process crashes, other processes are unaffected and can take over while Passenger restarts the crashed process.
 * **Reliably releasing memory**<br>
   Memory leaks are confined to a specific process. If you shut down a process, all of its memory is released automatically by the operating system.

## Characteristics and caveats

### Memory isolation

A process is *isolated* from other processes. "Isolated" means that processes don't share memory with each other. Suppose that your application has a variable `A` with initial value `A = 1`. If you run two instances of your application -- two processes -- and you tell one process to set `A = 2`, then the value `2` is only visible to that process. The other process still thinks `A == 1`!

### Sharing data between processes

You can't change variables in your program and expect all processes to see the changes. They won't. So how do you communicate changes to all your processes? The answer is by using a shared data store, such as:

 * The database.
 * Redis.
 * Memcached.

### Crash protection

If a process crashes, other processes do not crash along with it. An application crash won't take down Passenger because Passenger runs in its own process. Even Passenger itself is implemented as multiple processes, so that Passenger can restart itself when Passenger crashes.

## Seeing what's happening

How do you know which application processes are running, and what their statistics are such as CPU and memory usage? Experienced developers may be inclined to use the `ps` tool, but this is not a tool that we would recommend, for the following reasons:

 1. **Hard to read**<br>
    `ps` shows all processes on your system, not just processes managed by Passenger. This makes its output hard to read.
 2. **Inaccurate memory statistics**<br>
    `ps` shows various memory statistics, but none of those statistics accurately take shared memory into account.
 3. **Limited information**<br>
    `ps` can only display process-level information. But you may also be interested in transaction-level information, such as which requests are being handled by which processes.

For these reasons, Passenger provides a number of tools for reporting statistics.

### passenger-status

The `passenger-status` tool provides you with an overview of all your processes, how much CPU and memory they're using, etc.

    $ passenger-status
    Version : 4.0.37
    Date    : 2013-11-14 21:55:30 +0100
    Instance: 25002
    ----------- General information -----------
    Max pool size : 6
    Processes     : 1
    Requests in top-level queue : 0

    ----------- Application groups -----------
    /Users/phusion/testapp#default:
      App root: /Users/phusion/testapp
      Requests in queue: 0
      * PID: 25012   Sessions: 0       Processed: 2       Uptime: 9s
        CPU: 0%      Memory  : 14M     Last used: 3s ago

Here you see that Passenger is serving one application, `/Users/phusion/testapp`. Passenger is running 1 process for that application, namely PID 25012. That process is using 0% CPU and 14 MB memory.

### passenger-memory-stats

Besides `passenger-status`, there is also `passenger-memory-stats`. This tool allows you to inspect the memory usage of all processes related to Passenger, including the web server, Passenger itself and the applications. The difference with `passenger-status` is:

 * `passenger-status` does not display the web server's memory usage.
 * `passenger-status` does not display the memory usage of internal Passenger processes.
 * The metrics displayed by `passenger-status` are gathered by internal Passenger processes that run in the background. `passenger-memory-stats` displays information by querying ps and by querying the kernel. If the Passenger internal processes are malfunctioning, then `passenger-memory-stats` still works.

Here is an example of `passenger-memory-stats` in action:

    # passenger-memory-stats
    Version: 4.0.56
    Date   : 2015-01-28 17:10:53 +0100

    ---------- Apache processes ----------
    PID    PPID   VMSize    Private  Name
    --------------------------------------
    1529   10548  231.0 MB  39.0 MB  /usr/sbin/apache2 -k start
    1648   10548  220.1 MB  29.6 MB  /usr/sbin/apache2 -k start
    10548  1      193.2 MB  2.9 MB   /usr/sbin/apache2 -k start
    ### Processes: 3
    ### Total private dirty RSS: 71.5 MB


    --------- Nginx processes ---------
    PID   PPID  VMSize   Private  Name
    -----------------------------------
    7185  4762  59.5 MB  0.5 MB   nginx: master process /opt/production/nginx/sbin/nginx
    7254  7185  63.1 MB  4.6 MB   nginx: worker process
    ### Processes: 2
    ### Total private dirty RSS: 5.09 MB


    ----- Passenger processes ------
    PID    VMSize    Private   Name
    --------------------------------
    7236   89.6 MB   0.3 MB    PassengerWatchdog
    7239   229.5 MB  2.2 MB    PassengerHelperAgent
    7248   139.9 MB  1.9 MB    PassengerLoggingAgent
    7265   246.9 MB  71.0 MB   Passenger RackApp: /Users/phusion/testapp/current
    7428   451.0 MB  166.8 MB  Passenger RackApp: /Users/phusion/passenger_website/current
    ### Processes: 5
    ### Total private dirty RSS: 242.20 MB

## Process supervision

The cool thing about Passenger is that it restarts processes that crash! Let's try it out. Tell Passenger to spawn two processes:

    $ passenger start --min-instances 2
    ...

In another terminal, run `passenger-status` and obtain the PID of a random process. Then kill that process to simulate a crash.

    $ passenger-status
    ...
    $ kill <PID>

Wait a few seconds, and run `passenger-status` again. Notice that the original process is gone, but that it has been replaced by another one!

## Next step

Read the conclusion.

<a href="../conclusion.html" class="btn btn-primary btn-lg">Continue &raquo;</a>
