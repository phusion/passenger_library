# Phusion Passenger documentation project

Welcome to the Passenger documentation project. The goal of this project is to write excellent documentation for the [Phusion Passenger application server](https://www.phusionpassenger.com/).

You can view the live version of this documentation at [https://www.phusionpassenger.com/docs](https://www.phusionpassenger.com/docs/).

Documentation is written in markdown and HTML. The final output is generated through the [Middleman static site generator](https://middlemanapp.com/).

## Contributing

Because our documentation changes based on which language or integration the user chooses, our structure might feel a bit different than you're used to.

Let's say you choose Python as the language you are going to use and you want to edit the [Quickstart](https://www.phusionpassenger.com/docs/tutorials/quickstart/node/) article because you noticed we left something out. Here's how to find the right file:

You navigate to tutorials because Quickstart is an article in the tutorial section. From there you'll find an index.html.md.erb file and a directory for every language. The `index.html.md.erb` will contain the following script:

```
<script>document.addEventListener("DOMContentLoaded", function() { return redirect_to_lang() });</script>
```

This script will look at which language was chosen by the user and then redirect to that directory. So that's where you'll find the Python file you want to edit. Open the Python directory and edit the `index.html.md.erb` file.

Now sometimes you'll open the `index.html.md.erb` file and you might find that the only content is a [Middleman partial](https://middlemanapp.com/basics/partials/). For example in the [Installation](https://www.phusionpassenger.com/docs/tutorials/installations/node/) article you will find:

```
<%= render_partial("../shared/non_ruby") %>
```

In this case we're using the same content for multiple language options, navigate one directory back and open the `shared` directory and edit `_non_ruby.html.md.erb`.

Once you're done editing, create a pull request like you normally would.

**Thank you for contributing!**

_By contributing, you agree to license your contribution under [CC BY SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/)._

## Previewing or generating the documentation website

You will need Ruby installed in order to preview or generate the documentation website.

Install the gem bundle:

    bundle install

Then run Middleman:

    bundle exec middleman s

This will launch the website at http://127.0.0.1:4567/
