# RSpec matchers for Rail's `ActiveSupport::Notifications`.

## Installation

In your Gemfile add:

```ruby
group :test do
    gem 'rspec-matchers-active_support-notifications'
end
```

Add the matcher to your spec helper:

```ruby
RSpec.configure do |config|
    # [...]
    config.include Rspec::Matchers::ActiveSupport::Notifications
    # [...]
end
```

Or use it in your desired example:

```ruby
RSpec.describe 'my subject'
    include Rspec::Matchers::ActiveSupport::Notifications
    # [...]
end
```

## Usage

```ruby
# in your spec
it "emits X event" do
    expect { code }.to emit_event('X')
end

# An example closer to reality

it "triggers a SQL query" do
    expect { code }.to emit_event('sql.active_record').exactly(:once)
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## TODO:
- [ ] Add `#with` capabilities to match events based on payload values.
    + Something along the lines of:

    ```ruby
    expect { code }.to emit_event('sql.active_record').with(sql: /FROM "posts"/).exactly(:once)
    ```
- [ ] Find a way to understand how to negate these matchers, brain does not
  compute today.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/josegomezr/rspec-matchers-active_support-notifications.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
