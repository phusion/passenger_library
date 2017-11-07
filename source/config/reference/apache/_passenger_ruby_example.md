<pre class="highlight"><span class="c"># Use Ruby 2.1 by default.</span>
PassengerDefaultRuby /usr/bin/ruby2.1
<span class="c"># Use Python 2.6 by default.</span>
PassengerPython /usr/bin/python2.6
<span class="c"># Use /usr/bin/node by default.</span>
PassengerNodejs /usr/bin/node

&lt;VirtualHost *:80&gt;
    <span class="c"># This Ruby web app will use Ruby 2.1</span>
    ServerName www.foo.com
    DocumentRoot /webapps/foo/public
&lt;/VirtualHost&gt;

&lt;VirtualHost *:80&gt;
    <span class="c"># This Rails web app will use Ruby 2.2.1, as installed by RVM</span>
    PassengerRuby /usr/local/rvm/wrappers/ruby-2.2.1/ruby
    ServerName www.bar.com
    DocumentRoot /webapps/bar/public

    <span class="c"># If you have a web app deployed in a sub-URI, customize
    # PassengerRuby/PassengerPython inside a &lt;Location&gt; block.
    # The web app under www.bar.com/blog will use JRuby 1.7.1</span>
    Alias /blog /websites/blog/public
    &lt;Location /blog&gt;
        PassengerBaseURI /blog
        PassengerAppRoot /websites/blog

        PassengerRuby /usr/local/rvm/wrappers/jruby-1.7.1/ruby
    &lt;/Location&gt;
    &lt;Directory /websites/blog/public&gt;
        Allow from all
        Options -MultiViews
        <span class="c"># Uncomment this if you're on Apache >= 2.4:
        #Require all granted</span>
    &lt;/Directory&gt;
&lt;/VirtualHost&gt;

&lt;VirtualHost *:80&gt;
    <span class="c"># This Flask web app will use Python 3.0</span>
    PassengerPython /usr/bin/python3.0
    ServerName www.baz.com
    DocumentRoot /webapps/baz/public
&lt;/VirtualHost&gt;</pre>