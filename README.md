# I18nWigodo (I18n with Google Docs)

This gem offers a simple way of having cloud stored translations for
your Rails app.

Just create a new spreadsheet in Google Docs and make it world readable.
This makes integration of the gem easier since no credentials and
authentication mechanisms for Google are needed.

If this is a security concern for you, either this gem is not for you,
or you can revoke public read access to the document whenever you are
not syncing your translations.

You can share your document with write access to your translator.

To fetch new translations, run

```sh
rake wigodo:fetch
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'i18n_wigodo'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install i18n-wigodo

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## About

This concept was inspired by [Luki3k5](https://github.com/luki3k5) and his [google_spreadsheet2yml](https://github.com/luki3k5/google_spreadsheet2yml) gem.

# License

[MIT](https://github.com/mpm/i18n-wigodo/blob/master/LICENSE).

# Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mpm/i18n-wigodo. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

# Code of Conduct

Everyone interacting in the wigodo project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/mpm/i18n-wigodo/blob/master/CODE_OF_CONDUCT.md).
