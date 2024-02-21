# TestyJar

TestyJar provides a simple way to access plain, signed and encrypted cookies in Rails controller / request / integration tests.

## Usage

Inside your controller / integration / request test call `cookies_jar` helper to access cookies:

```ruby
cookies_jar.encrypted[:key]
cookies_jar.signed[:key] = value
```

If you try to set cookie after response has been processed, an error will be raised:

```ruby
get "/up"
cookies_jar[:key] = value
# => ArgumentError: Cannot write to cookies as the response has already been sent
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem "testy_jar"
```

And then execute:

```bash
$ bundle
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
