At its core, Passenger is a process manager. Instead of running an application inside its process space, Passenger launches the application as external processes, and manages them. Passenger load balances traffic between processes, shuts down processes when they're no longer needed or when they misbehave, keeps them running and restarts them when they crash, etc.

<div class="info">
  It you're not familiar with the concept of processes (and threads), please read <a href="<%= url_for '/indepth/processes.html' %>">About processes</a> first.
</div>

Initially, Passenger only spawns one application process. But sometimes it may decide to spawn multiple processes. Here are the reasons why this is sometimes beneficial:

 * **Performance**<br>
   The more processes you run, the better the CPU core utilization, up until the hardware limit.
 * **I/O concurrency**<br>
   The more processes you run, the greater the amount of available I/O concurrency.
 * **Stability**<br>
   If an application process crashes, other processes are unaffected and can take over while Passenger restarts the crashed process.
 * **Reliably releasing memory**<br>
   Memory leaks are confined to a specific process. If you shut down a process, all of its memory is released automatically by the operating system.