Passenger also supports the magic file 'tmp/always_restart.txt'. If this file exists, Passenger will restart your application after every request. This way you do not have to invoke the restart command often.

Activate this mechanism by creating the file:

<pre class="highlight"><span class="prompt">$ </span>mkdir -p tmp
<span class="prompt">$ </span>touch tmp/always_restart.txt</pre>

Deactivate this mechanism by removing the file:

<pre class="highlight"><span class="prompt">$ </span>rm tmp/always_restart.txt</pre>
