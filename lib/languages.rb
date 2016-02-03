# This file lists all programming platforms that are supported by Passenger.

LANG_RUBY = {
  choice_val: "ruby",
  # An identifier for this programming platform.
  language_type: :ruby,
  # The programming platform's display name.
  language_name: "Ruby",
  language_name_with_determiner: "a Ruby",
  # The programming platform's underlying programming language's name.
  language_runtime_name: "Ruby",
  # Whether the Deployment Walkthrough contains instructions on how to
  # install this programming platform.
  language_has_install_instructions: true,
  # The programming platform's default concurrency when used in Passenger.
  # A value of 0 means unlimited.
  language_default_concurrency: 1,
  # The programming platform's minimum and maximum concurrency as configurable
  # through Passenger. A value of 0 means unlimited.
  language_min_concurrency: 1,
  language_max_concurrency: 0,
  # The programming platform's per-process concurrency model. Possible values are:
  # - :thread -- concurrency through multithreading
  # - :coroutines -- concurrency through lightweight userspace threading,
  #     e.g. Erlang processes or Go goroutines
  # - :evented -- concurency through evented I/O
  language_concurrency_model: :thread,
  language_concurrency_model_name_plural: "threads"
}
LANG_PYTHON = {
  choice_val: "python",
  language_type: :python,
  language_name: "Python",
  language_name_with_determiner: "a Python",
  language_runtime_name: "Python",
  language_has_install_instructions: true,
  language_default_concurrency: 1,
  language_min_concurrency: 1,
  language_max_concurrency: 1,
  language_concurrency_model: :thread,
  language_concurrency_model_name_plural: "threads"
}
LANG_NODEJS = {
  choice_val: "nodejs",
  language_type: :nodejs,
  language_name: "Node.js",
  language_name_with_determiner: "a Node.js",
  language_runtime_name: "Node.js",
  language_has_install_instructions: true,
  language_default_concurrency: 0,
  language_min_concurrency: 1,
  language_max_concurrency: 0,
  language_concurrency_model: :evented,
  language_concurrency_model_name_plural: "evented I/O"
}
LANG_METEOR = {
  choice_val: "meteor",
  language_type: :meteor,
  language_name: "Meteor",
  language_name_with_determiner: "a Meteor",
  language_runtime_name: "Node.js",
  language_has_install_instructions: true,
  language_default_concurrency: 0,
  language_min_concurrency: 1,
  language_max_concurrency: 0,
  language_concurrency_model: :evented,
  language_concurrency_model_name_plural: "evented I/O"
}

# If you add an entry, be sure to also update SUPPORTED_APP_TYPES and
# SUPPORTED_APP_TYPE_CONVENTIONS.
SUPPORTED_LANGUAGES = [
  LANG_RUBY,
  LANG_PYTHON,
  LANG_NODEJS,
  LANG_METEOR
]


SUPPORTED_APP_TYPES = [
  { lang_key: "ruby",
    name: "Ruby, Ruby on Rails",
    type: "rack",
    startup_file: "config.ru" },
  { lang_key: "python",
    name: "Python",
    type: "wsgi",
    startup_file: "passenger_wsgi.py" },
  { lang_key: "meteor nodejs",
    name: "Node.js or Meteor JS in bundled/packaged mode",
    type: "node",
    startup_file: "app.js" },
  { lang_key: "meteor",
    name: "Meteor JS in non-bundled/packaged mode",
    type: "meteor",
    startup_file: ".meteor" }
]

SUPPORTED_APP_TYPE_CONVENTIONS = [
  { name: "Ruby, Ruby on Rails",
    type: "rack",
    startup_file: "config.ru" },
  { name: "Python",
    type: "wsgi",
    startup_file: "passenger_wsgi.py" },
  { name: "Node.js",
    type: "node",
    startup_file: "app.js" },
  { name: "Meteor JS in non-bundled/packaged mode",
    type: "meteor",
    startup_file: ".meteor" }
]
