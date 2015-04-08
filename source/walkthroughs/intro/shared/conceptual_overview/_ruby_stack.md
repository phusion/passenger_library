When you deploy your web app to production, there are all sorts of components involved. You may have heard of Unicorn, Puma, Nginx, Apache and Capistrano. Passenger replaces some components, while collaborating with other components.

In a typical production stack, one would use Nginx or Apache as the web server, Passenger as application server, and Capistrano as release automation tool. Passenger integrates with Nginx or Apache and manages the application and its resources.

### Nginx and Apache

Nginx and Apache are web servers. They provide HTTP transaction handling and serve static files. However, they are not Ruby application servers and cannot run Ruby applications. That is why Nginx and Apache are used in combination with an application server, such as Passenger.

Application servers make it possible for Ruby apps to speak HTTP. Ruby apps (and frameworks like Rails) can't do that by themselves. On the other hand, application servers typically aren't as good as Nginx and Apache at handling HTTP requests. That's why, in production environments, application servers are used in combination with Nginx or Apache.

### Capistrano

Capistrano is an application release automation tool. When releasing a new version of your web application, there are actions that need to be performed, such as uploading your application code to your servers, running a command to install your gem bundle, restarting processes, etc. Capistrano allows you to automate these actions.

Capistrano is not a server that provides HTTP transaction handling, so it does not replace application servers or web servers. Instead, you are supposed to use Capistrano in combination with them. For example, Capistrano scripts typically contain instructions to restart the application server after a new application version has been released.

### Unicorn and Puma

Unicorn and Puma are alternative application servers. Passenger replaces Unicorn and Puma.

Passenger's feature set is very different from those of Unicorn and Puma. In particular, Passenger has a stronger focus on ease of use, integration with other components, automatic management and enabling problem diagnosis. For example, Passenger can integrate with Nginx and Apache in order to reduce setup work, and provides tools for easy problem diagnosis.
