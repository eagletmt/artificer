# Artificer

artificer is a simple fixture replacement.
Features and syntax are highly inspired by [machinist](https://github.com/notahat/machinist).

## Features

- Creates a record from blueprint definition by `Model.make`
    - Attributes can be overridden by `Model.make(name: 'foo')`.
- Loads blueprint definition lazily
    - It's beneficial for applications which have so many models.

## Installation

Add this line to your application's Gemfile:

    gem 'artificer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install artificer

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/eagletmt/artificer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
