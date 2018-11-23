# NCCO

[Nexmo Call Control Objects](https://developer.nexmo.com/voice/voice-api/ncco-reference) (NCCOs) allow you to decide with your code what happens in a phone call which you've placed or received using [Nexmo's Voice API](https://developer.nexmo.com/voice/voice-api/overview).

If you make a mistake in your NCCO (for example, you miss out a required parameter or misspell something), the call will fail.

This gem allows you to __validate__ your NCCOs before you send them to Nexmo, giving you a tighter feedback loop and helping you to catch errors earlier, before they hit production (for example when you run your tests).

## Installation

Add this line to your application's `Gemfile`:

```ruby
gem "ncco", "~> 0.1.0"
```

Next, install the gem by running:

```bash
bundle
```

## Usage

Nexmo Call Control Objects (NCCOs) are JSON arrays of objects. In Ruby, you'll build a Ruby array of hashes, where each hash represents an "action" in your call, and then you'll send it to Nexmo as JSON:

```ruby
say_hello = {
  action: "talk",
  text: "Hello there! You're through to Acme Widgets. Leave a message after the tone. Press star or hang up when you're done.",
}

record_message = {
  action: "record",
  endOnKey: "*",
  beepStart: true,
  eventUrl: "https://acmewidgets.com/nexmo/recordings",
  eventMethod: "POST",
  format: "mp4"
}

ncco = [say_hello, record_message]
render json: ncco
```

The eagle-eyed among you will have noticed that there's a mistake in our example above: Nexmo doesn't support the `mp4` format for recordings! This would lead to an error, and a bad experience for our users 😭

But there's a better way:

```ruby
require "ncco"

render json: NCCO.build(ncco)
```

This will still fail - our NCCO is invalid! - but our application will let us know ahead of time:

```ruby
NCCO.build(ncco)
# NCCO::InvalidActionError (The 2nd action is invalid: format must be one of: mp3, wav,
# ogg, eventUrl must be a valid HTTP or HTTPS URL)
```

This allows you to catch errors earlier and easily handle them with your usual exception tracking tools (for example Sentry).

## Development

After checking out the repo, run `bin/setup` to install dependencies.

Then, run `rake spec` to run the tests and `rake lint` to check the code style with Rubocop.

You can also run `bin/console` for an interactive prompt that will allow you to experiment with the gem.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

NCCO "actions" are defined using schemas in `lib/ncco/schemas`, implemented using [dry-validation](https://github.com/dry-rb/dry-validation).

To tweak how we validate an action (for example to add a new attribute or change how an existing one is validated), just update the action's corresponding schema. Testing is easy thanks to our `allow_value`, `require_attribute` and `allow_blank_values` matchers - see the existing tests for an example.

If you want to add support for a new action, you'll need to crerate a new schema in `lib/ncco/schemas`, require it and add it to `SCHEMAS_BY_TYPE` in `lib/ncco.rb` and write some tests.

Bug reports and pull requests are welcome on GitHub at https://github.com/timrogers/ncco. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Ncco project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/timrogers/ncco/blob/master/CODE_OF_CONDUCT.md).
