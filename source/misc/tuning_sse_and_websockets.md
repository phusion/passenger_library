---
title: Tuning for Server Sent Events and WebSockets
section: misc
sidebar: sidebar
---
# Tuning for Server Sent Events and WebSockets

Passenger supports Server Sent Events (SSE) and WebSockets out of the box with no configuration, but there are some things you need to know.

First, WebSockets are [not yet supported when using the Apache integration mode](https://github.com/phusion/passenger/issues/1202).

Second, for Ruby apps only, you need to insert a configuration snippet inside your `config.ru`:

~~~ruby
if defined?(PhusionPassenger)
  PhusionPassenger.advertised_concurrency_level = 0
end
~~~

<div class="note">
  <p>
    This snippet tells Passenger that your Ruby app will handle SSE and WebSockets. In response, Passenger will adjust the connection concurrency settings for your app. Without this configuration snippet, SSE and WebSockets still work, but with degraded performance.
  </p>
  <p>
    This configuration snippet is currently necessary because of the way Passenger is implemented. We are <a href="https://github.com/phusion/passenger/issues/1195">working on improving this mechanism</a>. One day, the above configuration snippet will no longer be necessary. For now, you should include the above configuration snippet for optimal SSE and WebSocket performance.
  </p>
</div>

Finally, you can find Passenger SSE and WebSocket demo apps on [the Passenger documentation overview page](https://www.phusionpassenger.com/documentation_and_support), under section "Demos".