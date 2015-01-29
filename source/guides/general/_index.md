<h1 class="page-header">General guides</h1>
<p class="lead">Learn to use the awesome features in Passenger.</p>

### Basics

 * Application restarting
 * Application code reloading
 * Static assets serving
 * Process management
 * Environment variables
 * Concurrency model
 * Command line tools

### Web technologies support

 * WebSockets
 * Server Sent Events

### Optimization & efficiency

 * [Code preloading]()
   <br><small>Reducing memory usage and startup time.</small>
 * [Multithreading]()
   <br><small>Lowering memory usage and increasing I/O concurrency.</small>
 * [Turbocaching]()
   <br><small>A high-performance, builtin HTTP response cache</small>
 * [Out-of-band work &amp; out-of-band garbage collection]()
   <br><small>Reducing garbage collection delays.</small>
 * [Maximizing concurrency]()
 * [Minimizing memory usage]()

### Troubleshooting

 * Combatting memory bloat and memory leaks
 * Analyzing and fixing stuck applications
 * Attaching an IRB console to an application process
   <span class="label label-ruby">Ruby only</span>

### Ruby support

 * Bundler integration
 * Rack socket hijacking
 * RVM integration
 * Rbenv integration
 * Chruby integration
 * Using multiple Ruby versions without a Ruby manager
 * Rails page caching support

### Node.js support

 * NPM integration
 * Automatic process scaling

### Advanced & internals

 * Architectural overview
 * Request queuing and load balancing
 * Spawn methods
 * Hooks
 * Accessing individual application processes

### Enterprise

 * Upgrading to Phusion Passenger Enterprise
 * Enterprise features
 * Cloud licensing configuration

### TODO

 * Why is Passenger is a good choice?
  - Ruby
    - Compared to Unicorn
    - Compared to Puma
  Node.js
    - Talk about Forever and PM2
    - Talk about the Cluster module
