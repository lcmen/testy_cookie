# TestyCookie

`TestyCookie` provides a helper to access plain, permanent, signed and encrypted cookies consistently in Rails controller / integration / request tests.

## Why do I need a custom helper?

`ActionDispatch::IntegrationTest` based tests and RSpec request specs do not provide `encrypted`, `permanent` and `signed` stores on the default `cookies` jar. `TestyCookie` workaround it by initializing `ActionDispatch::Cookies::CookieJar` instance and propagating all changes back to the original `cookies` object (`Rack::Test::CookieJar` instance).

In `ActionController::TestCase` tests and RSpec controller specs (which are going to be deprecated), it's just an alias for the default `cookies` method.

## Usage

Inside your controller / integration / request test, call `cookies_jar` helper to access cookies jar:

```ruby
cookies_jar.encrypted[:key]
cookies_jar.signed[:key] = value
cookies_jar.signed.encrypted.permanent[:key] = value
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem "testy_cookie"
```

And then execute:

```bash
$ bundle
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
