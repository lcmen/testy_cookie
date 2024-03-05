# TestyCookie

`TestyCookie` gem provides a helper for accessing plain, permanent, signed, and encrypted cookies in Rails controller, integration, and request tests.

## Why do I need a custom helper?

In Rails `ActionDispatch::IntegrationTest` based tests and RSpec request specs do not provide `encrypted`, `permanent` and `signed` stores on the default `cookies` store. `TestyCookie` resolves this limitation by initializing an `ActionDispatch::Cookies::CookieJar` instance. Dedicated helper propagates all changes made back to the original cookies object (`Rack::Test::CookieJar` instance), ensuring consistent behavior across different types of tests.

In `ActionController::TestCase` tests and RSpec controller specs, `cookies_jar` serves as an alias for the default `cookies` method.

## Usage

Inside your controller / integration / request test, call `cookie_jar` helper to access cookies jar:

```ruby
cookie_jar.encrypted[:key]
cookie_jar.signed[:key] = value
cookie_jar.signed.encrypted.permanent[:key] = value
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
