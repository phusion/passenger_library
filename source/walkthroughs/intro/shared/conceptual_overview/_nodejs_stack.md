When you deploy your web app to production, there are all sorts of components involved. You may have heard of PM2, Forever, Nginx and Cluster. Passenger replaces some components, while collaborating with other components.

In a typical production stack, one would use Nginx as the web server and Passenger as application server and process management tool. Passenger integrates with Nginx and manages the application and its resources.

### Nginx

...
