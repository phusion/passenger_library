## Passenger and "rails server"

The Ruby on Rails framework provides a builtin server, which you can access with the `rails server` command. The "rails server" is not an application server by itself, but just a small wrapper that launches your application in an application server. This is why people do not use "rails server" in production. They use an application server -- such as Passenger -- directly.

"rails server" uses [WEBrick](http://ruby-doc.org/stdlib-2.2.0/libdoc/webrick/rdoc/WEBrick.html) by default. This is the builtin Ruby HTTP server, but it isn't a good choice for production because it's slow.

Instead of launching "rails server", you would launch Passenger. At the moment, it is not possible to make "rails server" launch Passenger automatically, though we are working on that.
