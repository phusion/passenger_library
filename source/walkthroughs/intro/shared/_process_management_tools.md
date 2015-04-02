How do you know which application processes are running, and what their statistics are such as CPU and memory usage? Experienced developers may be inclined to use the `ps` tool, but this is not a tool that we would recommend, for the following reasons:

 1. **Ps is hard to read**<br>
    `ps` shows all processes on your system, not just processes managed by Passenger. This makes its output hard to read.
 2. **Ps has inaccurate memory statistics**<br>
    `ps` shows various memory statistics, but none of those statistics accurately take shared memory into account.
 3. **Ps provides limited information**<br>
    `ps` can only display process-level information. But you may also be interested in transaction-level information, such as which requests are being handled by which processes.

For these reasons, Passenger provides a number of tools for reporting statistics.

### passenger-status

The `passenger-status` tool provides you with an overview of all your processes, how much CPU and memory they're using, etc.

~~~bash
passenger-status
# => Version : 5.0.6
# => Date    : 2015-04-14 21:55:30 +0100
# => Instance: 25002
# => ----------- General information -----------
# => Max pool size : 6
# => Processes     : 1
# => Requests in top-level queue : 0
# => 
# => ----------- Application groups -----------
# => /Users/phusion/testapp#default:
# =>   App root: /Users/phusion/testapp
# =>   Requests in queue: 0
# =>   * PID: 25012   Sessions: 0       Processed: 2       Uptime: 9s
# =>     CPU: 0%      Memory  : 14M     Last used: 3s ago
~~~

Here you see that Passenger is serving one application, `/Users/phusion/testapp`. Passenger is running 1 process for that application, namely PID 25012. That process is using 0% CPU and 14 MB memory.

### passenger-memory-stats

Besides `passenger-status`, there is also `passenger-memory-stats`. This tool allows you to inspect the memory usage of all processes related to Passenger, including the web server, Passenger itself and the applications. The difference with `passenger-status` is:

 * `passenger-status` does not display the web server's memory usage.
 * `passenger-status` does not display the memory usage of internal Passenger processes.
 * The metrics displayed by `passenger-status` are gathered by internal Passenger processes that run in the background. `passenger-memory-stats` displays information by querying ps and by querying the kernel. If the Passenger internal processes are malfunctioning, then `passenger-memory-stats` still works.

Here is an example of `passenger-memory-stats` in action:

~~~bash
passenger-memory-stats
# => Version: 4.0.56
# => Date   : 2015-01-28 17:10:53 +0100
# => 
# => ---------- Apache processes ----------
# => PID    PPID   VMSize    Private  Name
# => --------------------------------------
# => 1529   10548  231.0 MB  39.0 MB  /usr/sbin/apache2 -k start
# => 1648   10548  220.1 MB  29.6 MB  /usr/sbin/apache2 -k start
# => 10548  1      193.2 MB  2.9 MB   /usr/sbin/apache2 -k start
# => ### Processes: 3
# => ### Total private dirty RSS: 71.5 MB
# => 
# => 
# => --------- Nginx processes ---------
# => PID   PPID  VMSize   Private  Name
# => -----------------------------------
# => 7185  4762  59.5 MB  0.5 MB   nginx: master process /usr/sbin/nginx
# => 7254  7185  63.1 MB  4.6 MB   nginx: worker process
# => ### Processes: 2
# => ### Total private dirty RSS: 5.09 MB
# => 
# => 
# => ----- Passenger processes ------
# => PID    VMSize    Private   Name
# => --------------------------------
# => 7236   89.6 MB   0.3 MB    PassengerWatchdog
# => 7239   229.5 MB  2.2 MB    PassengerHelperAgent
# => 7248   139.9 MB  1.9 MB    PassengerLoggingAgent
# => 7265   246.9 MB  71.0 MB   Passenger RackApp: /Users/phusion/testapp/current
# => 7428   451.0 MB  166.8 MB  Passenger RackApp: /Users/phusion/passenger_website/current
# => ### Processes: 5
# => ### Total private dirty RSS: 242.20 MB
~~~
