# KMData

A simple API wrapper for interacting with the [KMData](https://kmdata.osu.edu/) Project.

## Installation

Add this line to your application's Gemfile:

    gem 'kmdata'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kmdata

## Usage

    terms = KMData.get('terms')

    terms.each do |term|
      puts term.description
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
